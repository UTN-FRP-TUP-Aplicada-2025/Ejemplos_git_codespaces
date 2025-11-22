using Ejemplo_API_Web.DTOs;

namespace Ejemplo_API_Web.Services;

public interface IPersonaService
{
    List<PersonaDto> ObtenerTodas();
    PersonaDto? ObtenerPorId(int id);
    PersonaDto Crear(PersonaDto persona);
    bool Actualizar(int id, PersonaDto persona);
    bool Eliminar(int id);
}
