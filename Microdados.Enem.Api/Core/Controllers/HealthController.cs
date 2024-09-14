using Microsoft.AspNetCore.Mvc;

namespace Core.Controllers
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