using Core.Data;
using Core.Data.Models;
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
        [Route("exam/{id}/canceled-questions-count")]
        public async Task<IActionResult> GetExamCanceledQuestionsCount(int id)
        {
            IEnumerable<Item>? items = await DbContext.Provas
                .Where(p => p.ProvaId == id)
                .Include(p => p.ItensPorProva)
                .ThenInclude(ip => ip.Item)
                .Select(p => p.ItensPorProva.Select(ip => ip.Item))
                .FirstOrDefaultAsync();

            if (items == null) return BadRequest("EXAM_NOT_FOUND");

            int count = items.Where(i => i.FoiAbandonado).Count();
            return Ok(new GetExamCanceledQuestionsCountResponse(Count: count));
        }
    }
}