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
    }
}