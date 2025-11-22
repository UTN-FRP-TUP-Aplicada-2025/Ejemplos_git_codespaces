# 🎯 GitHub Actions - Workflows Configurados

## 📊 Resumen de Workflows

Se han configurado **4 workflows de GitHub Actions** para automatizar completamente el build y deploy:

### 1. **build-deploy.yml** 🎯 (Principal - Recomendado)
**Ejecuta:** Cada push a `main`

```
┌─────────────────────────────────────┐
│  Build .NET 10 (PersonasAPI)        │
│  ✅ Compilar en Release             │
│  ✅ Validar sintaxis                │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Build Node.js (backend - opcional) │
│  ✅ npm install                     │
│  ✅ Validar server.js               │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Deploy Frontend a GitHub Pages     │
│  ✅ Copiar web/                     │
│  ✅ Upload artifact                 │
│  ✅ Deploy automático               │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│  Mostrar resumen de despliegue      │
│  ✅ URLs                            │
│  ✅ Próximos pasos                  │
└─────────────────────────────────────┘
```

**Tiempo estimado:** 2-3 minutos

---

### 2. **deploy-api.yml** 🔧 (Backend Node.js)
**Ejecuta:** Cambios en `backend/`

- ✅ Setup Node.js 18
- ✅ npm install
- ✅ Validar código
- ✅ Notificar opciones de despliegue

---

### 3. **deploy-frontend.yml** 🚀 (Frontend)
**Ejecuta:** Cambios en `web/` o `README*.md`

- ✅ Preparar archivos
- ✅ Setup GitHub Pages
- ✅ Upload artifact
- ✅ Deploy automático

---

### 4. **deploy-railway.yml** 🚄 (Backend a Railway)
**Ejecuta:** Cambios en `PersonasAPI/` (manual o con RAILWAY_TOKEN)

- ✅ Compilar .NET
- ✅ Publicar
- ✅ Deploy a Railway (si está configurado)

---

## 🔄 Flujo Completo

```
1. Haces git push
                ↓
2. GitHub Actions detecta cambios
                ↓
3. Se inician los workflows automáticamente
                ↓
   ┌─────────────┬─────────────┐
   ↓             ↓             ↓
 .NET       Node.js       Frontend
  Build      Build        Assets
                ↓             ↓
                └─────┬───────┘
                      ↓
            Upload a GitHub Pages
                      ↓
            ✅ En vivo automáticamente
```

---

## 📍 URLs después del Deploy

### Frontend (GitHub Pages)
```
https://utn-frp-tup-aplicada-2025.github.io/Ejemplos_gitpages/
```

Se actualiza automáticamente en cada push.

### Backend - Opciones

**Opción 1: Local (para desarrollo)**
```bash
# Terminal 1: Ejecutar backend
cd PersonasAPI
dotnet run
# http://localhost:5265

# Terminal 2: Abrir frontend
# Abre: web/index.html
# Configura URL: http://localhost:5265
```

**Opción 2: Railway (Producción)**
```bash
# Primero, agregar RAILWAY_TOKEN
# Settings → Secrets and variables → Actions
# Agregar: RAILWAY_TOKEN

# Luego, el workflow deploy-railway.yml desplegará automáticamente
```

**Opción 3: Render**
1. Conectar repo en render.com
2. Root Directory: `PersonasAPI`
3. Build Command: `dotnet restore && dotnet build`
4. Start Command: `dotnet PersonasAPI.dll`

**Opción 4: Vercel**
1. Conectar repo en vercel.com
2. Framework: .NET
3. Vercel configura automáticamente

---

## 📈 Ver Estado de los Workflows

Ve a: **Actions** en tu repositorio GitHub

```
https://github.com/UTN-FRP-TUP-Aplicada-2025/Ejemplos_gitpages/actions
```

Verás:
- ✅ Workflows ejecutados
- ⏱️ Tiempo de ejecución
- 📊 Logs detallados
- ❌ Errores (si ocurren)

---

## 🔧 Configuración de Secretos (Opcional)

Para desplegar automáticamente el backend, agrega secretos en:
**Settings → Secrets and variables → Actions**

```
RAILWAY_TOKEN=<tu-token-de-railway>
RENDER_TOKEN=<tu-token-de-render>
VERCEL_TOKEN=<tu-token-de-vercel>
```

---

## 📊 Próximos Pasos

### 1. Verificar que el Frontend está en GitHub Pages

```bash
git log --oneline
# Deberías ver el último commit

# Luego abre:
# https://utn-frp-tup-aplicada-2025.github.io/Ejemplos_gitpages/
```

### 2. Desplegar el Backend

Elige una opción:

**Railway** (Recomendado)
```bash
npm install -g @railway/cli
railway login
cd PersonasAPI
railway init
railway up
```

**Render**
- Conectar repo
- Crear Web Service
- Build: `dotnet restore && dotnet build`
- Start: `dotnet PersonasAPI.dll`

**Vercel**
```bash
npm install -g vercel
vercel
```

### 3. Actualizar Frontend con URL del Backend

En `web/config.html`:
```javascript
usePreset('https://tu-api.railway.app', 'Producción')
```

---

## 🎯 Checklist de Despliegue

- [ ] Verificar que `build-deploy.yml` se ejecutó correctamente
- [ ] Abrir GitHub Pages: `https://utn-frp-tup-aplicada-2025.github.io/Ejemplos_gitpages/`
- [ ] Desplegar backend en Railway/Render/Vercel
- [ ] Obtener URL del backend
- [ ] Configurar URL en web/config.html
- [ ] Probar CRUD completo
- [ ] ✅ ¡En producción!

---

## 🔗 Links Útiles

- 📚 Documentación GitHub Actions: https://docs.github.com/actions
- 🚄 Railway: https://railway.app
- 🎨 Render: https://render.com
- ⚡ Vercel: https://vercel.com
- 📄 README-GITHUB-ACTIONS.md: Guía detallada

---

## 💡 Tips

1. **Para forzar un re-run:** Ve a Actions → Workflow → Re-run all jobs

2. **Para ver logs:** Actions → Último workflow → Haz clic en cada job

3. **Para desactivar un workflow:** Agrega `# [skip ci]` en el commit message

4. **Para workflows manuales:** Usa `workflow_dispatch`

---

**Estado:** ✅ Todos los workflows configurados y listos para usar
