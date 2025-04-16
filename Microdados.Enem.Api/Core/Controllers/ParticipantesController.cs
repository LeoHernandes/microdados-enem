using Core.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Core.Controllers
{
    [ApiController]
    public class ParticipantesController(AppDbContext dbContext) : ControllerBase
    {
        private AppDbContext DbContext { get; set; } = dbContext;

        public record PostSubscriptionValidateRequest(string Subscription);
        public record GetParticipantScoreResponse(
            float ScoreCH,
            float ScoreCN,
            float ScoreLC,
            float ScoreMT,
            float ScoreRE,
            float ScoreMean
         );

        [HttpPost]
        [Route("subscription/validate")]
        public async Task<IActionResult> PostSubscriptionValidate([FromBody] PostSubscriptionValidateRequest request)
        {
            bool participantExists = await DbContext.Participantes.Where(p => p.ParticipanteId == request.Subscription).AnyAsync();
            if (participantExists)
            {
                return Ok();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpGet]
        [Route("participant/score")]
        public async Task<IActionResult> GetParticipantScore([FromQuery] string subscription)
        {
            var scores = await DbContext.Participantes
                .Where(p => p.ParticipanteId == subscription)
                .Select(p => new { p.NotaCH, p.NotaCN, p.NotaLC, p.NotaMT, p.NotaRE })
                .FirstOrDefaultAsync();

            if (scores == null) return BadRequest();

            float mean = (scores.NotaCH + scores.NotaCN + scores.NotaLC + scores.NotaMT + scores.NotaRE) / 5;

            return Ok(new GetParticipantScoreResponse(
                ScoreCH: scores.NotaCH,
                ScoreCN: scores.NotaCN,
                ScoreLC: scores.NotaLC,
                ScoreMT: scores.NotaMT,
                ScoreRE: scores.NotaRE,
                ScoreMean: mean
            ));
        }
    }
}