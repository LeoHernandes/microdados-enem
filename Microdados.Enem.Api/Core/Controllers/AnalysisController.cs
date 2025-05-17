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
            if (!Enum.TryParse<Area>(areaId, ignoreCase: true, out Area parsedAreaId))
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
            if (!Enum.TryParse<Area>(areaId, ignoreCase: false, out Area parsedAreaId))
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
    }
}