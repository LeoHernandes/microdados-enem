using Core.DbData;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Core.Controllers
{
    [ApiController]
    public class ParticipantesController(AppDbContext dbContext) : ControllerBase
    {
        private AppDbContext DbContext { get; set; } = dbContext;

        [HttpGet]
        [Route("participantes")]
        public async Task<IActionResult> GetParticipantesCount()
        {
            long count = await DbContext.Participantes.LongCountAsync();

            return Ok(count);
        }
    }
}