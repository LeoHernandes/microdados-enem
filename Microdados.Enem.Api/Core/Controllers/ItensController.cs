using Core.Data;
using Core.Data.Models;
using Microsoft.AspNetCore.Mvc;

namespace Core.Controllers
{
    [ApiController]
    public class ItensController(AppDbContext dbContext) : ControllerBase
    {
        private AppDbContext DbContext { get; set; } = dbContext;

        [HttpGet]
        [Route("itens")]
        public async Task<IActionResult> GetHealthStatus()
        {
            var item = new Item
            {
                FoiAbandonado = true,
                Gabarito = 'A',
                HabilidadeId = 1,
                ParamAcaso = 0.5,
                ParamDiscriminacao = 0.5,
                ParamDificuldade = 0.5,
            };
            await DbContext.AddAsync(item);
            await DbContext.SaveChangesAsync();

            return Ok();
        }
    }
}