using ClinicaWebApi.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ClinicaWebApi.Controllers
{
    [ApiController]
    [Route("api/v1/[controller]")]
    public class lugarController : Controller
    {
        [HttpGet]
        public IActionResult GetLugar()
        {
            // Lógica para devolver los lenguajes
            return Ok(new[] { "English", "Spanish", "French" });
        }

        [HttpPost]
        public IActionResult GetLugarById([FromBody] lugar _lugar)
        {
            // Lógica para devolver los lenguajes
            return Ok(new[] { "English", "Spanish", "French" });
        }
    }
}
