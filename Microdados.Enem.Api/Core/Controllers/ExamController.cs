using Core.Data;
using Core.Data.Models;
using Core.Enem;
using Core.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Core.Controllers
{
    [ApiController]
    public class ItensController(AppDbContext dbContext) : ControllerBase
    {
        private AppDbContext DbContext { get; set; } = dbContext;

        [HttpGet]
        [Route("exam/{areaId}/canceled-questions-count")]
        public async Task<IActionResult> GetExamCanceledQuestionsCount(string areaId, [FromQuery] bool? reapplication)
        {
            if (!Enum.TryParse<Area>(areaId, ignoreCase: false, out Area parsedAreaId))
            {
                return NotFound();
            }

            IEnumerable<Item>? items = await DbContext.Provas
                .Where(p => p.AreaSigla == areaId && p.Reaplicacao == (reapplication ?? false))
                .Include(p => p.ItensPorProva)
                .ThenInclude(ip => ip.Item)
                .Select(p => p.ItensPorProva.Select(ip => ip.Item))
                .FirstOrDefaultAsync();

            if (items == null) return BadRequest("EXAM_NOT_FOUND");

            int count = items.Where(i => char.ToLower(i.Gabarito) == 'x').Count();
            return Ok(new GetExamCanceledQuestionsCountResponse(Count: count));
        }
    }
}