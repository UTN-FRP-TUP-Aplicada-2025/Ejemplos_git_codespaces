---
layout: default
title: "API Personas - Documentación"
---

# 🚀 API Personas - .NET 10

## ¿Qué es?

API REST completa construida con **.NET 10** alojada en **GitHub Codespaces** y expuesta a través de **GitHub Pages** usando el proxy integrado de Codespaces.

## 🎯 Características

- ✅ **API REST completa** con CRUD de personas
- ✅ **.NET 10** - Framework moderno y performante
- ✅ **Swagger/OpenAPI** - Documentación interactiva
- ✅ **Docker** - Containerización automática
- ✅ **GitHub Actions** - CI/CD automático
- ✅ **GitHub Pages** - Documentación pública
- ✅ **GitHub Codespaces** - Desarrollo en la nube

## 📱 Acceder a la API

### Opción 1: A través del Proxy (Recomendado)

[Abrir Proxy de Codespaces →](api-proxy.html)

La página te mostrará:
- URL pública de tu API
- Botón para abrir Swagger UI
- Pruebas de conexión

### Opción 2: Localmente

```bash
cd Ejemplos_codespaces/Ejemplo_API_Web
dotnet run
```

Accede a: `http://localhost:5265/swagger`

### Opción 3: Con Docker

```bash
docker run -p 5000:80 ghcr.io/UTN-FRP-TUP-Aplicada-2025/Ejemplos_git_codespaces/api:latest
```

Accede a: `http://localhost:5000/swagger`

## 🔗 Endpoints

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/api/personas` | Obtener todas las personas |
| GET | `/api/personas/{id}` | Obtener persona por ID |
| POST | `/api/personas` | Crear nueva persona |
| PUT | `/api/personas/{id}` | Actualizar persona |
| DELETE | `/api/personas/{id}` | Eliminar persona |

## 📊 Stack Tecnológico

```
Frontend:  HTML5 + CSS3 + JavaScript
API:       .NET 10 Core + ASP.NET Web API
Docs:      Swagger/OpenAPI + GitHub Pages
Deploy:    GitHub Actions + Docker + Codespaces
Hosting:   GitHub Pages (docs) + Codespaces (API)
```

## 🔄 Flujo de Funcionamiento

```
1. Push a GitHub (main)
   ↓
2. GitHub Actions compila .NET 10
   ↓
3. Construye imagen Docker
   ↓
4. Publica en GitHub Container Registry
   ↓
5. GitHub Pages actualiza documentación
   ↓
6. API disponible en Codespaces
   ↓
7. Proxy de Codespaces expone URL pública
```

## 📦 Modelos de Datos

### PersonaDto

```json
{
  "id": 1,
  "nombre": "Juan",
  "apellido": "Pérez",
  "email": "juan@example.com",
  "edad": 30
}
```

## 🧪 Probar la API

### Con curl

```bash
# Obtener todas
curl https://<codespace-name>-5265.app.github.dev/api/personas

# Crear
curl -X POST https://<codespace-name>-5265.app.github.dev/api/personas \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Ana","apellido":"García","email":"ana@example.com","edad":28}'
```

### Con Swagger UI

Accede a: `https://<codespace-name>-5265.app.github.dev/swagger`

## 📚 Documentación Adicional

- [Cómo Ejecutar]({{ site.baseurl }}/COMO_EJECUTAR.md)
- [Ejemplo de uso local]({{ site.baseurl }}/docs/api-proxy.html)
- [Repositorio GitHub](https://github.com/UTN-FRP-TUP-Aplicada-2025/Ejemplos_git_codespaces)

## 🛠️ Configuración Local

### Requisitos

- .NET 10 SDK
- Git
- Docker (opcional)

### Instalación

```bash
git clone https://github.com/UTN-FRP-TUP-Aplicada-2025/Ejemplos_git_codespaces.git
cd Ejemplos_git_codespaces/Ejemplos_codespaces/Ejemplo_API_Web
dotnet restore
dotnet run
```

## 🚀 Deploy Automático

Cada `push` a `main` automáticamente:

1. ✅ Compila el proyecto
2. ✅ Ejecuta tests
3. ✅ Construye Docker image
4. ✅ Publica en GitHub Container Registry
5. ✅ Actualiza GitHub Pages

Ver status en: [Actions](https://github.com/UTN-FRP-TUP-Aplicada-2025/Ejemplos_git_codespaces/actions)

## 💡 Tips

- La URL del proxy cambia según tu Codespace (usar la página proxy)
- La API está disponible 24/7 mientras Codespaces esté activo
- CORS está habilitado para acceso desde cualquier dominio
- Swagger actualiza automáticamente con cambios en la API

## 📞 Soporte

Para problemas o preguntas:
- [Abrir Issue](https://github.com/UTN-FRP-TUP-Aplicada-2025/Ejemplos_git_codespaces/issues)
- [Diskusiones](https://github.com/UTN-FRP-TUP-Aplicada-2025/Ejemplos_git_codespaces/discussions)

---

**Última actualización:** {{ site.time | date: "%d de %B de %Y" }}

**Versión:** .NET 10.0.100 | v1.0.0
