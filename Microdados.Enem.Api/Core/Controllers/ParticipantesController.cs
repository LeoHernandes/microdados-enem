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
    public class ParticipantesController(AppDbContext dbContext) : ControllerBase
    {
        private AppDbContext DbContext { get; set; } = dbContext;

        [HttpPost]
        [Route("participant/check-in")]
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
        [Route("participant/{id}/score")]
        public async Task<IActionResult> GetParticipantScore(string id)
        {
            var scores = await DbContext.Participantes
                .Where(p => p.ParticipanteId == id)
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

        [HttpGet]
        [Route("participant/{id}/score-on-area/{areaId}")]
        public async Task<IActionResult> GetParticipantScoreOnArea(string id, string areaId)
        {
            if (!Enum.TryParse<Area>(areaId, ignoreCase: true, out var parsedAreaId))
            {
                return BadRequest("INVALID_AREA");
            }

            Dictionary<Area, Expression<Func<Participante, UserTestDTO>>> areaSelector = new()
            {
                [Area.CH] = p => new UserTestDTO(p.ProvaIdCH, p.LinguaEstrangeira, p.RespostasCH, p.NotaCH),
                [Area.CN] = p => new UserTestDTO(p.ProvaIdCN, p.LinguaEstrangeira, p.RespostasCN, p.NotaCN),
                [Area.LC] = p => new UserTestDTO(p.ProvaIdLC, p.LinguaEstrangeira, p.RespostasLC, p.NotaLC),
                [Area.MT] = p => new UserTestDTO(p.ProvaIdMT, p.LinguaEstrangeira, p.RespostasMT, p.NotaMT),
            };

            UserTestDTO? userTestDTO = await DbContext.Participantes
                .Where(p => p.ParticipanteId == id)
                .Select(areaSelector[parsedAreaId])
                .FirstOrDefaultAsync();
            if (userTestDTO == null) return BadRequest();

            IEnumerable<char>? testItens = await DbContext.Provas
               .Where(p => p.ProvaId == userTestDTO.Code)
               .Select(
                    p => p.ItensPorProva
                        .OrderBy(ip => ip.Posicao)
                        // If the item is from foreign language, check the participant choice
                        .Where(ip => ip.Item.LinguaEstrangeira == null || ip.Item.LinguaEstrangeira == userTestDTO.language)
                        .Select(ip => ip.Item.Gabarito)
                )
               .FirstOrDefaultAsync();

            if (testItens == null) return BadRequest();

            int correctItemsCount = testItens
                .Select((item, index) => item == userTestDTO.Answers[index] ? 1 : 0)
                .Sum();

            return Ok(new GetParticipantScoreOnAreaResponse(
                Score: userTestDTO.Score,
                CorrectItemsCount: correctItemsCount
            ));
        }

        record UserTestDTO(int Code, ForeignLanguage language, string Answers, float Score);
    }
}