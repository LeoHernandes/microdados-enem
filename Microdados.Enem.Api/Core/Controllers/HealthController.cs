using Microsoft.AspNetCore.Mvc;

namespace Microdados.Enem.Api.Core.Controllers
{
    [ApiController]
    public class HealthController : ControllerBase
    {
        [HttpGet]
        [Route("health")]
        public IActionResult GetHealthStatus()
        {
            return Ok("Alive!");
        }
    }
}