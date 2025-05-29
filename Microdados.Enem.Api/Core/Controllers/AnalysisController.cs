using System.Linq.Expressions;
using Core.Data;
using Core.Data.Models;
using Core.Enem;
using Core.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Core.Controllers
{
    [ApiController]
    public class AnalysisController(AppDbContext dbContext) : ControllerBase
    {
        private AppDbContext DbContext { get; set; } = dbContext;

        [HttpGet]
        [Route("analysis/answer-score-relation")]
        public async Task<IActionResult> GetAnswerScoreRelation([FromQuery] int rightAnswers, [FromQuery] string areaId, [FromQuery] bool? reapplication)
        {
            if (!Enum.TryParse(areaId, ignoreCase: true, out Area parsedAreaId))
            {
                return BadRequest("INVALID_AREA");
            }

            Dictionary<Area, Expression<Func<Participante, float>>> scoreSelector = new()
            {
                [Area.CH] = p => p.NotaCH,
                [Area.CN] = p => p.NotaCN,
                [Area.LC] = p => p.NotaLC,
                [Area.MT] = p => p.NotaMT,
            };

            Dictionary<Area, Expression<Func<Participante, bool>>> rightsFilter = new()
            {
                [Area.CH] = p => p.AcertosCH == rightAnswers && p.ProvaCH.Reaplicacao == (reapplication ?? false),
                [Area.CN] = p => p.AcertosCN == rightAnswers && p.ProvaCN.Reaplicacao == (reapplication ?? false),
                [Area.LC] = p => p.AcertosLC == rightAnswers && p.ProvaLC.Reaplicacao == (reapplication ?? false),
                [Area.MT] = p => p.AcertosMT == rightAnswers && p.ProvaMT.Reaplicacao == (reapplication ?? false),
            };

            float[] scores = await DbContext.Participantes
                .Where(rightsFilter[parsedAreaId])
                .Select(scoreSelector[parsedAreaId])
                .ToArrayAsync();

            if (scores.Length == 0)
            {
                return Ok();
            }

            (float min, float max) = scores.Aggregate(
               seed: (Min: float.MaxValue, Max: float.MinValue),
               func: (acc, num) => (Math.Min(acc.Min, num), Math.Max(acc.Max, num))
            );

            Dictionary<int, int> histogram = Discretize(min, max, scores);

            return Ok(new GetAnswerScoreRelationResponse(
                MinScore: min,
                MaxScore: max,
                Histogram: histogram
            ));
        }

        private static Dictionary<int, int> Discretize(float start, float end, float[] values)
        {
            const int MAX_INTERVALS = 5;
            const int MIN_INTERVAL_SIZE = 10;

            float dataRange = end - start;
            int intervalSize = Math.Max(MIN_INTERVAL_SIZE, (int)Math.Round(dataRange / MAX_INTERVALS));

            return values
             .GroupBy(score =>
             {
                 double group = Math.Floor(score / intervalSize) * intervalSize;
                 if (group <= start) return group + intervalSize;
                 if (group >= end) return group - intervalSize;
                 return group;
             })
             .OrderBy(group => group.Key)
             .ToDictionary(
                 group => (int)group.Key,
                 group => group.Count()
             );
        }

        [HttpGet]
        [Route("analysis/difficulty-distribution/{areaId}")]
        public async Task<IActionResult> GetExamDifficulryDistribution(string areaId, [FromQuery] ForeignLanguage? language, [FromQuery] bool? reapplication)
        {
            if (!Enum.TryParse(areaId, ignoreCase: false, out Area parsedAreaId))
            {
                return NotFound();
            }

            var itemsByExam = await DbContext.Provas
                .Where(p => p.AreaSigla == areaId && p.Reaplicacao == (reapplication ?? false))
                .Include(p => p.ItensPorProva)
                .ThenInclude(ip => ip.Item)
                .Select(p => new ItemsByExamDTO
                (
                    p.Cor,
                    p.ItensPorProva
                        .Where(ip => ip.Item.LinguaEstrangeira == null || ip.Item.LinguaEstrangeira == language)
                        .Select(ip => new QuestionDifficulty
                        (
                            ip.Posicao,
                            ip.Item.ParamDificuldade
                        ))

                ))
                .FirstOrDefaultAsync();

            if (itemsByExam == null) return BadRequest("EXAM_NOT_FOUND");

            double? lowestDifficulty = itemsByExam.Items.Min(i => i.Difficulty);
            Dictionary<int, double?> distributionDict = itemsByExam.Items
                .OrderBy(item => item.Position)
                .ToDictionary(
                    item => item.Position,
                    item => item.Difficulty.HasValue
                        ? lowestDifficulty < 0
                            ? ((item.Difficulty - lowestDifficulty) * 100 + 300)
                            : item.Difficulty * 100 + 300
                        : null
            );

            KeyValuePair<int, double?> easiestQuestion = distributionDict
                .Aggregate((a, b) => a.Value > b.Value ? b : a);

            KeyValuePair<int, double?> hardestQuestion = distributionDict
                .Aggregate((a, b) => a.Value < b.Value ? b : a);

            return Ok(new GetDifficultyDistributionResponse
            (
                Color: itemsByExam.Color ?? "",
                EasiestQuestion: new QuestionDifficulty
                (
                    Position: easiestQuestion.Key,
                    Difficulty: easiestQuestion.Value
                ),
                HardestQuestion: new QuestionDifficulty
                (
                    Position: hardestQuestion.Key,
                    Difficulty: hardestQuestion.Value
                ),
                Distribution: distributionDict
            )
            );
        }

        record ItemsByExamDTO(string? Color, IEnumerable<QuestionDifficulty> Items);

        [HttpGet]
        [Route("analysis/school-type-distribution")]
        public async Task<IActionResult> GetSchoolTypeDistribution()
        {
            var counts = await DbContext.Participantes
                .GroupBy(p => p.TipoEscola)
                .Select(group => new
                {
                    SchoolType = group.Key,
                    Count = group.Count()
                })
                .ToListAsync();

            return Ok(new GetSchoolTypeDistributionResponse
            (
                UnknownCount: counts.Find(c => c.SchoolType == SchoolType.Uknown)!.Count,
                PublicCount: counts.Find(c => c.SchoolType == SchoolType.Public)!.Count,
                PrivateCount: counts.Find(c => c.SchoolType == SchoolType.Private)!.Count
            ));
        }

        [HttpGet]
        [Route("analysis/score-average-by-school-type")]
        public async Task<IActionResult> GetScoreAverageBySchoolType()
        {
            var scores = await DbContext.Participantes
                .Where(p => p.TipoEscola != SchoolType.Uknown)
                .GroupBy(p => p.TipoEscola)
                .Select(group => new
                {
                    SchoolType = group.Key,
                    AverageCH = group.Average(p => p.NotaCH),
                    AverageCN = group.Average(p => p.NotaCN),
                    AverageLC = group.Average(p => p.NotaLC),
                    AverageMT = group.Average(p => p.NotaMT),
                    AverageEssay = group.Average(p => p.NotaRE),
                })
                .ToListAsync();

            var publicScores = scores.Find(c => c.SchoolType == SchoolType.Public)!;
            var privateScores = scores.Find(c => c.SchoolType == SchoolType.Private)!;

            return Ok(new GetAverageScoreBySchoolTypeResponse
            (
                PublicSchoolScores: new Scores(
                    AverageCH: publicScores.AverageCH,
                    AverageCN: publicScores.AverageCN,
                    AverageLC: publicScores.AverageLC,
                    AverageMT: publicScores.AverageMT,
                    AverageEssay: publicScores.AverageEssay
                ),
                PrivateSchoolScores: new Scores(
                    AverageCH: privateScores.AverageCH,
                    AverageCN: privateScores.AverageCN,
                    AverageLC: privateScores.AverageLC,
                    AverageMT: privateScores.AverageMT,
                    AverageEssay: privateScores.AverageEssay
                )
            ));
        }

        [HttpGet]
        [Route("analysis/score-distribution-by-school-type/{areaId}")]
        public async Task<IActionResult> GetScoreDistributionBySchoolType(string areaId, [FromQuery] bool? reapplication)
        {
            if (!Enum.TryParse(areaId, ignoreCase: false, out Area parsedAreaId))
            {
                return NotFound();
            }

            Dictionary<Area, Expression<Func<Participante, int>>> groupingPolicy = new()
            {
                [Area.CH] = p => (int)Math.Floor(p.NotaCH / 100) * 100,
                [Area.CN] = p => (int)Math.Floor(p.NotaCN / 100) * 100,
                [Area.LC] = p => (int)Math.Floor(p.NotaLC / 100) * 100,
                [Area.MT] = p => (int)Math.Floor(p.NotaMT / 100) * 100,
            };

            var publicScores = await DbContext.Participantes
                .Where(p => p.TipoEscola == SchoolType.Public)
                .GroupBy(groupingPolicy[parsedAreaId])
                .Select(scoreGroup => new
                {
                    Score = scoreGroup.Key,
                    Count = scoreGroup.Count(),
                })
                .ToListAsync();

            var privateScores = await DbContext.Participantes
                .Where(p => p.TipoEscola == SchoolType.Private)
                .GroupBy(groupingPolicy[parsedAreaId])
                .Select(scoreGroup => new
                {
                    Score = scoreGroup.Key,
                    Count = scoreGroup.Count(),
                })
                .ToListAsync();

            return Ok(new GetScoreDistributionBySchoolTypeResponse(
                PublicSchoolDistribution: publicScores
                    .ToDictionary(s => s.Score, s => s.Count),
                PrivateSchoolDistribution: privateScores
                    .ToDictionary(s => s.Score, s => s.Count)
            ));
        }
    }
}