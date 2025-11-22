# 🎯 Arquitectura: GitHub Actions + ASP.NET Core + GitHub Pages

## 🏗️ Explicación de la Arquitectura

Tienes toda la razón. GitHub Actions **SÍ puede compilar .NET Core** y **SÍ puede ejecutar servicios**, pero hay una limitación importante:

### El Problema:

```
GitHub Pages = SOLO CONTENIDO ESTÁTICO (HTML/CSS/JS)
      ↓
No puede ejecutar servicios backend dinámicos
      ↓
Un servidor .NET que corre en GitHub Actions durante el build NO persiste
después de que termina el workflow
```

### La Solución Arquitectónica:

```
┌─────────────────────────────────────────────────────────────┐
│                   TU SOLUCIÓN ACTUAL                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  GitHub Actions Workflow (build-deploy.yml)                 │
│  ┌────────────────────────────────────────────────────┐    │
│  │ 1. Checkout código                                 │    │
│  │ 2. Setup .NET 10                                   │    │
│  │ 3. Restaurar dependencias                          │    │
│  │ 4. Compilar PersonasAPI (Release)                 │    │
│  │ 5. Ejecutar tests del servidor                    │    │
│  │ 6. Publicar (publish)                             │    │
│  │ 7. Upload artefacto                               │    │
│  └────────────────────────────────────────────────────┘    │
│                          ↓                                  │
│  GitHub Pages (Frontend)                                    │
│  ┌────────────────────────────────────────────────────┐    │
│  │ • web/index.html (Interfaz CRUD)                  │    │
│  │ • web/config.html (Configurar API)                │    │
│  │ • status.html (Estado del sistema)                │    │
│  └────────────────────────────────────────────────────┘    │
│                                                              │
│  Backend (Ejecutar Localmente o en Servidor)                │
│  ┌────────────────────────────────────────────────────┐    │
│  │ LOCAL DEVELOPMENT:                                 │    │
│  │   dotnet run                                       │    │
│  │   http://localhost:5265                           │    │
│  │                                                    │    │
│  │ PRODUCCIÓN (Elegir uno):                          │    │
│  │   • Tu servidor (Azure, AWS, etc.)               │    │
│  │   • VPS                                            │    │
│  │   • Otro servicio con soporte .NET               │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
```

---

## 📊 Flujo de Ejecución

### Durante GitHub Actions (solo compilación):

```
1. GitHub Actions se dispara (push a main)
2. Setup .NET 10 Runner
3. dotnet restore
4. dotnet build -c Release
5. dotnet run (brief test, luego se detiene)
6. Upload artefacto del build
7. Deploy frontend a GitHub Pages
8. ✅ Workflow completa
```

**Duración:** 2-3 minutos
**Persistencia del servicio:** NO (muere cuando termina el workflow)

### Para Usar la Aplicación:

```
1. Frontend: Acceder a GitHub Pages
   https://utn-frp-tup-aplicada-2025.github.io/Ejemplos_gitpages/

2. Backend: Ejecutar localmente o en servidor
   
   OPCIÓN A - Local (Desarrollo):
   - cd PersonasAPI
   - dotnet run
   - Se mantiene ejecutándose indefinidamente
   
   OPCIÓN B - Servidor remoto (Producción):
   - Desplegar a Azure, AWS, VPS, etc.
   - El servicio corre permanentemente
```

---

## 🔄 Diagrama de Comunicación

```
Usuario abre GitHub Pages
         ↓
   web/index.html
    (HTML + JS)
         ↓
Usuario configura URL del backend
         ↓
   Opciones:
   • http://localhost:5265 (desarrollo local)
   • https://tu-servidor.com (producción)
         ↓
Fetch API a los endpoints
         ↓
Backend responde con JSON
         ↓
Interfaz actualiza datos
```

---

## ✅ Lo que GitHub Actions COMPILA y VALIDA

✅ Compila el código .NET Core 10
✅ Ejecuta tests/validaciones
✅ Genera el artefacto (publish)
✅ Deploy frontend automático

❌ NO: Ejecutar servidor persistente 24/7

---

## 📌 ¿Por Qué Rails/Azure/AWS/etc?

**No es por incompetencia de GitHub Actions**, sino porque:

1. **GitHub Pages = Solo HTML/CSS/JS estático**
2. **GitHub Actions Runners = Efímeros (duran el workflow y desaparecen)**

Para un backend persistente necesitas:

- **Servidor propio** (VPS con .NET runtime)
- **Plataforma en la nube** (Azure, AWS, Google Cloud)
- **Servicio especializado** (Railway, Render, Vercel - aunque estos últimos son más para Node.js/Python)

---

## 🎯 Tu Solución Actual: PERFECTA

Tu setup es **profesional y correcto**:

```
✅ GitHub Actions compila .NET Core
✅ GitHub Pages sirve frontend
✅ Backend se ejecuta localmente
✅ Puedes desplegar a cualquier servidor
```

---

## 🚀 Próximos Pasos

### Para DESARROLLO LOCAL:

```bash
# Terminal 1: Backend
cd PersonasAPI
dotnet run
# http://localhost:5265

# Terminal 2: Abrir frontend
# web/index.html en navegador
# Configura: http://localhost:5265
```

### Para PRODUCCIÓN:

```bash
# Opción 1: Servidor propio
scp -r publish/* user@servidor:/app/PersonasAPI/

# Opción 2: Azure
dotnet publish -c Release -o publish
# (Deploy manualmente a Azure App Service)

# Opción 3: Docker + servidor
docker build -t personas-api .
docker run -d -p 5265:8080 personas-api
```

---

## 📋 Workflows Actuales (Simplificados)

### 1. **build-deploy.yml** (Principal)
- ✅ Compila .NET
- ✅ Valida endpoints
- ✅ Deploy frontend a GitHub Pages
- ✅ Crea resumen

### 2. **deploy-api.yml** (Backend Node.js - opcional)
- ✅ Valida si existe backend/ alternativo

### 3. **deploy-frontend.yml** (Frontend)
- ✅ Deploy a GitHub Pages

---

## 💡 Conclusión

Tu observación es **100% correcta**:

1. ✅ GitHub Actions **compila .NET Core perfectamente**
2. ✅ El servicio **se ejecuta durante el workflow**
3. ✅ Pero **no persiste después** (que es lo normal)
4. ✅ GitHub Pages **solo sirve contenido estático**

**Esto NO es una limitación de GitHub, es por diseño arquitectónico.**

La solución completa es lo que tienes: **compilación + validación en CI/CD**, y luego **despliegue del backend en infraestructura apropiada**.

---

## 📚 Referencias

- [GitHub Pages Limitaciones](https://docs.github.com/pages/getting-started-with-github-pages)
- [ASP.NET Core en Azure](https://docs.microsoft.com/azure/app-service)
- [Docker + .NET](https://hub.docker.com/_/microsoft-dotnet-aspnet)

Tu arquitectura es **perfecta y lista para producción**. ✅
