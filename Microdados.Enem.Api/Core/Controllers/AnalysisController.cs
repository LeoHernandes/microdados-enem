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
        public async Task<IActionResult> GetAnswerScoreRelation([FromQuery] int rightAnswers, [FromQuery] string areaId)
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
                [Area.CH] = p => p.AcertosCH == rightAnswers,
                [Area.CN] = p => p.AcertosCN == rightAnswers,
                [Area.LC] = p => p.AcertosLC == rightAnswers,
                [Area.MT] = p => p.AcertosMT == rightAnswers,
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
            const int MAX_INTERVALS = 6;
            const int MIN_INTERVAL_SIZE = 10;

            float dataRange = end - start;
            int intervalSize = Math.Max(MIN_INTERVAL_SIZE, (int)Math.Round(dataRange / MAX_INTERVALS));

            return values
             .GroupBy(score => Math.Floor(score / intervalSize) * intervalSize)
             .OrderBy(group => group.Key)
             .ToDictionary(
                 group => (int)group.Key,
                 group => group.Count()
             );
        }
    }
}