using Microsoft.AspNetCore.Mvc;
using Ejemplo_API_Web.DTOs;
using Ejemplo_API_Web.Services;

namespace Ejemplo_API_Web.Controllers;

[ApiController]
[Route("api/[controller]")]
public class PersonasController : ControllerBase
{
    private readonly IPersonaService _personaService;

    public PersonasController(IPersonaService personaService)
    {
        _personaService = personaService;
    }

    /// <summary>
    /// Obtiene todas las personas
    /// </summary>
    /// <returns>Lista de todas las personas</returns>
    [HttpGet]
    public ActionResult<IEnumerable<PersonaDto>> ObtenerTodas()
    {
        var personas = _personaService.ObtenerTodas();
        return Ok(personas);
    }

    /// <summary>
    /// Obtiene una persona por su ID
    /// </summary>
    /// <param name="id">ID de la persona</param>
    /// <returns>La persona solicitada</returns>
    [HttpGet("{id}")]
    public ActionResult<PersonaDto> ObtenerPorId(int id)
    {
        var persona = _personaService.ObtenerPorId(id);
        if (persona == null)
        {
            return NotFound(new { mensaje = $"Persona con ID {id} no encontrada" });
        }
        return Ok(persona);
    }

    /// <summary>
    /// Crea una nueva persona
    /// </summary>
    /// <param name="personaDto">Datos de la persona a crear</param>
    /// <returns>La persona creada</returns>
    [HttpPost]
    public ActionResult<PersonaDto> Crear(PersonaDto personaDto)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var persona = _personaService.Crear(personaDto);
        return CreatedAtAction(nameof(ObtenerPorId), new { id = persona.Id }, persona);
    }

    /// <summary>
    /// Actualiza una persona existente
    /// </summary>
    /// <param name="id">ID de la persona a actualizar</param>
    /// <param name="personaDto">Nuevos datos de la persona</param>
    /// <returns>Sin contenido si es exitoso</returns>
    [HttpPut("{id}")]
    public IActionResult Actualizar(int id, PersonaDto personaDto)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }

        var resultado = _personaService.Actualizar(id, personaDto);
        if (!resultado)
        {
            return NotFound(new { mensaje = $"Persona con ID {id} no encontrada" });
        }

        return NoContent();
    }

    /// <summary>
    /// Elimina una persona
    /// </summary>
    /// <param name="id">ID de la persona a eliminar</param>
    /// <returns>Sin contenido si es exitoso</returns>
    [HttpDelete("{id}")]
    public IActionResult Eliminar(int id)
    {
        var resultado = _personaService.Eliminar(id);
        if (!resultado)
        {
            return NotFound(new { mensaje = $"Persona con ID {id} no encontrada" });
        }

        return NoContent();
    }
}
