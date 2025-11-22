using PersonasAPI.DTOs;

namespace PersonasAPI.Services;

public interface IPersonaService
{
    List<PersonaDto> ObtenerTodas();
    PersonaDto? ObtenerPorId(int id);
    PersonaDto Crear(PersonaDto persona);
    bool Actualizar(int id, PersonaDto persona);
    bool Eliminar(int id);
}

public class PersonaService : IPersonaService
{
    private static List<PersonaDto> _personas = new()
    {
        new PersonaDto { Id = 1, Nombre = "Juan", Apellido = "Pérez", Email = "juan.perez@example.com", Edad = 30 },
        new PersonaDto { Id = 2, Nombre = "María", Apellido = "García", Email = "maria.garcia@example.com", Edad = 28 },
        new PersonaDto { Id = 3, Nombre = "Carlos", Apellido = "López", Email = "carlos.lopez@example.com", Edad = 35 },
        new PersonaDto { Id = 4, Nombre = "Ana", Apellido = "Martínez", Email = "ana.martinez@example.com", Edad = 26 }
    };

    private static int _nextId = 5;

    public List<PersonaDto> ObtenerTodas()
    {
        return _personas.OrderBy(p => p.Id).ToList();
    }

    public PersonaDto? ObtenerPorId(int id)
    {
        return _personas.FirstOrDefault(p => p.Id == id);
    }

    public PersonaDto Crear(PersonaDto persona)
    {
        persona.Id = _nextId++;
        _personas.Add(persona);
        return persona;
    }

    public bool Actualizar(int id, PersonaDto persona)
    {
        var personaExistente = _personas.FirstOrDefault(p => p.Id == id);
        if (personaExistente == null)
            return false;

        personaExistente.Nombre = persona.Nombre;
        personaExistente.Apellido = persona.Apellido;
        personaExistente.Email = persona.Email;
        personaExistente.Edad = persona.Edad;

        return true;
    }

    public bool Eliminar(int id)
    {
        var persona = _personas.FirstOrDefault(p => p.Id == id);
        if (persona == null)
            return false;

        _personas.Remove(persona);
        return true;
    }
}
