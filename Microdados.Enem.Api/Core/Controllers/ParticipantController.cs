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
    public class ParticipantController(AppDbContext dbContext) : ControllerBase
    {
        private AppDbContext DbContext { get; set; } = dbContext;

        [HttpPost]
        [Route("participant/check-in")]
        public async Task<IActionResult> PostParticipantCheckIn([FromBody] PostParticipantCheckInRequest request)
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
            if (!Enum.TryParse<Area>(areaId, ignoreCase: true, out Area parsedAreaId))
            {
                return BadRequest("INVALID_AREA");
            }

            Dictionary<Area, Expression<Func<Participante, UserTestDTO>>> areaSelector = new()
            {
                [Area.CH] = p => new UserTestDTO(p.AcertosCH, p.NotaCH),
                [Area.CN] = p => new UserTestDTO(p.AcertosCN, p.NotaCN),
                [Area.LC] = p => new UserTestDTO(p.AcertosLC, p.NotaLC),
                [Area.MT] = p => new UserTestDTO(p.AcertosMT, p.NotaMT),
            };

            UserTestDTO? userTestDTO = await DbContext.Participantes
                .Where(p => p.ParticipanteId == id)
                .Select(areaSelector[parsedAreaId])
                .FirstOrDefaultAsync();
            if (userTestDTO == null) return BadRequest();

            return Ok(new GetParticipantScoreOnAreaResponse(
                Score: userTestDTO.Score,
                RightAnswersCount: userTestDTO.RightAnswersCount
            ));
        }

        record UserTestDTO(int RightAnswersCount, float Score);

        [HttpGet]
        [Route("participant/{id}/pedagogical-coherence/{areaId}")]
        public async Task<IActionResult> GetParticipantPedagogicalCoherence(string id, string areaId)
        {
            if (!Enum.TryParse<Area>(areaId, ignoreCase: true, out Area parsedAreaId))
            {
                return BadRequest("INVALID_AREA");
            }

            Dictionary<Area, Expression<Func<Participante, ParticipantPedagogicalCoherenceDTO>>> areaSelector = new()
            {
                [Area.CH] = p => new ParticipantPedagogicalCoherenceDTO(
                    p.LinguaEstrangeira,
                    p.ProvaCH.Cor ?? "",
                    p.RespostasCH,
                    p.AcertosCH,
                    p.ProvaCH.ItensPorProva
                        .Select(ip => new ItemDTO(ip.Posicao, ip.Item.ParamDificuldade, ip.Item.Gabarito, ip.Item.LinguaEstrangeira)
                        )),
                [Area.CN] = p => new ParticipantPedagogicalCoherenceDTO(
                    p.LinguaEstrangeira,
                    p.ProvaCN.Cor ?? "",
                    p.RespostasCN,
                    p.AcertosCN,
                    p.ProvaCN.ItensPorProva
                        .Select(ip => new ItemDTO(ip.Posicao, ip.Item.ParamDificuldade, ip.Item.Gabarito, ip.Item.LinguaEstrangeira)
                        )),
                [Area.LC] = p => new ParticipantPedagogicalCoherenceDTO(
                    p.LinguaEstrangeira,
                    p.ProvaLC.Cor ?? "",
                    p.RespostasLC,
                    p.AcertosLC,
                    p.ProvaLC.ItensPorProva
                        .Select(ip => new ItemDTO(ip.Posicao, ip.Item.ParamDificuldade, ip.Item.Gabarito, ip.Item.LinguaEstrangeira)
                        )),
                [Area.MT] = p => new ParticipantPedagogicalCoherenceDTO(
                    p.LinguaEstrangeira,
                    p.ProvaMT.Cor ?? "",
                    p.RespostasMT,
                    p.AcertosMT,
                    p.ProvaMT.ItensPorProva
                        .Select(ip => new ItemDTO(ip.Posicao, ip.Item.ParamDificuldade, ip.Item.Gabarito, ip.Item.LinguaEstrangeira)
                        )),
            };

            ParticipantPedagogicalCoherenceDTO? dto = await DbContext.Participantes
                .Where(p => p.ParticipanteId == id)
                .Select(areaSelector[parsedAreaId])
                .FirstOrDefaultAsync();

            if (dto == null) return BadRequest();

            IEnumerable<ItemDTO> filteredItems = dto.ExamItems
                .Where(item => item.Language == null || item.Language == dto.Language);

            Dictionary<int, bool> difficultyRule = GetParticipantDifficultyRule(dto.ExamAnswers, filteredItems);

            return Ok(new GetParticipantPedagogicalCoherenceResponse(
                ExamColor: dto.ExamColor,
                RightAnswers: dto.RightAnswers,
                DifficultyRule: difficultyRule
            ));
        }

        private static Dictionary<int, bool> GetParticipantDifficultyRule(string participantAnswers, IEnumerable<ItemDTO> items)
        {
            return items
                .OrderBy(item => item.Position)
                .Select((item, index) => new
                {
                    position = item.Position,
                    difficulty = item.Difficulty,
                    rightAnswer = char.ToLower(item.RightAnswer) != 'x' && participantAnswers[index] == item.RightAnswer,
                })
                .Where(item => item.difficulty != null)
                .OrderBy(item => item.difficulty)
                .ToDictionary(
                    item => item.position, // null check in `Where`statement above
                    item => item.rightAnswer
                );
        }

        record ParticipantPedagogicalCoherenceDTO(
            ForeignLanguage? Language,
            string ExamColor, string ExamAnswers,
            int RightAnswers,
            IEnumerable<ItemDTO> ExamItems
        );

        record ItemDTO(int Position, double? Difficulty, char RightAnswer, ForeignLanguage? Language);
    }
}