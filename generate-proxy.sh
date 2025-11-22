#!/bin/bash

# Script para exponer la API de Codespaces a través de GitHub Pages

CODESPACE_NAME=${CODESPACE_NAME:-"unknown"}
PORT=5265
DOMAIN="app.github.dev"

# Generar URL pública
PUBLIC_URL="https://${CODESPACE_NAME}-${PORT}.${DOMAIN}"

echo "================================"
echo "🚀 API Codespaces Proxy"
echo "================================"
echo "Codespace: $CODESPACE_NAME"
echo "Puerto: $PORT"
echo "URL Pública: $PUBLIC_URL"
echo "================================"

# Crear directorio de documentación
mkdir -p ./docs

# Generar página HTML con la URL
cat > ./docs/api-proxy.html << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>API Personas - Proxy</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 600px;
            padding: 40px;
        }
        h1 {
            color: #667eea;
            margin-bottom: 20px;
            text-align: center;
        }
        .info-box {
            background: #f8f9fa;
            border: 2px solid #667eea;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
        }
        .url-box {
            background: #e7f3ff;
            border: 1px solid #b3d9ff;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
        }
        .url-box code {
            display: block;
            background: #004085;
            color: #fff;
            padding: 15px;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            overflow-x: auto;
            margin: 10px 0;
            word-break: break-all;
        }
        .btn {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 12px 24px;
            border-radius: 6px;
            text-decoration: none;
            margin: 10px 5px 0 0;
            border: none;
            cursor: pointer;
            font-size: 1em;
        }
        .btn:hover {
            background: #764ba2;
        }
        .btn.secondary {
            background: #6c757d;
        }
        .btn.secondary:hover {
            background: #5a6268;
        }
        .endpoints {
            margin-top: 30px;
        }
        .endpoint {
            background: #f8f9fa;
            padding: 15px;
            margin: 10px 0;
            border-radius: 4px;
            border-left: 4px solid #28a745;
        }
        .endpoint code {
            background: white;
            padding: 4px 8px;
            border-radius: 2px;
            font-family: monospace;
        }
        .status {
            text-align: center;
            margin: 20px 0;
            padding: 15px;
            border-radius: 8px;
        }
        .status.loading {
            background: #fff3cd;
            color: #856404;
        }
        .status.success {
            background: #d4edda;
            color: #155724;
        }
        .status.error {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 API Personas - Codespaces</h1>
        
        <div class="info-box">
            <p>Esta página se conecta directamente a tu instancia de GitHub Codespaces usando el proxy nativo.</p>
        </div>

        <div class="url-box">
            <strong>URL Pública de tu API:</strong>
            <code id="apiUrl">Cargando...</code>
            <button class="btn" onclick="copyToClipboard()">📋 Copiar URL</button>
            <button class="btn secondary" onclick="testAPI()">🧪 Probar conexión</button>
        </div>

        <div id="status" class="status loading" style="display:none;">
            <span id="statusText">Probando conexión...</span>
        </div>

        <div class="endpoints">
            <h2 style="color: #667eea; margin-bottom: 15px;">📍 Endpoints</h2>
            
            <div class="endpoint">
                <strong>GET</strong> <code>/api/personas</code>
                <p style="margin-top: 5px; color: #666;">Obtener todas las personas</p>
            </div>

            <div class="endpoint">
                <strong>GET</strong> <code>/api/personas/{id}</code>
                <p style="margin-top: 5px; color: #666;">Obtener persona por ID</p>
            </div>

            <div class="endpoint">
                <strong>POST</strong> <code>/api/personas</code>
                <p style="margin-top: 5px; color: #666;">Crear nueva persona</p>
            </div>

            <div class="endpoint">
                <strong>PUT</strong> <code>/api/personas/{id}</code>
                <p style="margin-top: 5px; color: #666;">Actualizar persona</p>
            </div>

            <div class="endpoint">
                <strong>DELETE</strong> <code>/api/personas/{id}</code>
                <p style="margin-top: 5px; color: #666;">Eliminar persona</p>
            </div>
        </div>

        <div style="margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee;">
            <h3 style="color: #667eea; margin-bottom: 10px;">🔗 Links útiles</h3>
            <p>
                <button class="btn" onclick="window.open(document.getElementById('apiUrl').textContent + '/swagger', '_blank')">
                    📖 Abrir Swagger UI
                </button>
                <button class="btn secondary" onclick="window.open(document.getElementById('apiUrl').textContent + '/api/personas', '_blank')">
                    🔍 Ver API JSON
                </button>
            </p>
        </div>
    </div>

    <script>
        // Obtener datos del servidor
        async function loadCodespaceInfo() {
            try {
                const response = await fetch('codespace-info.json');
                const data = await response.json();
                document.getElementById('apiUrl').textContent = data.publicUrl;
                document.title = `API Personas - ${data.codspaceName}`;
            } catch (error) {
                console.error('Error cargando info:', error);
                document.getElementById('apiUrl').textContent = 'URL no disponible';
            }
        }

        function copyToClipboard() {
            const url = document.getElementById('apiUrl').textContent;
            navigator.clipboard.writeText(url).then(() => {
                alert('✅ URL copiada al portapapeles');
            });
        }

        async function testAPI() {
            const baseUrl = document.getElementById('apiUrl').textContent;
            const statusDiv = document.getElementById('status');
            const statusText = document.getElementById('statusText');
            
            statusDiv.style.display = 'block';
            statusDiv.className = 'status loading';
            statusText.textContent = '⏳ Probando conexión...';

            try {
                const response = await fetch(baseUrl + '/api/personas');
                if (response.ok) {
                    const data = await response.json();
                    statusDiv.className = 'status success';
                    statusText.textContent = `✅ Conexión exitosa! Se encontraron ${data.length} personas.`;
                } else {
                    statusDiv.className = 'status error';
                    statusText.textContent = `❌ Error: ${response.status} ${response.statusText}`;
                }
            } catch (error) {
                statusDiv.className = 'status error';
                statusText.textContent = `❌ Error de conexión: ${error.message}`;
            }
        }

        // Cargar info al iniciar
        loadCodespaceInfo();
    </script>
</body>
</html>
EOF

echo "✅ Página HTML generada en ./docs/api-proxy.html"

# Generar archivo JSON con la información
cat > ./docs/codespace-info.json << EOJSON
{
  "codspaceName": "${CODESPACE_NAME}",
  "port": ${PORT},
  "domain": "${DOMAIN}",
  "publicUrl": "${PUBLIC_URL}",
  "timestamp": "$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
}
EOJSON

echo "✅ Información del Codespace guardada en ./docs/codespace-info.json"
echo ""
echo "URL pública: $PUBLIC_URL"
echo "Swagger UI: $PUBLIC_URL/swagger"
echo "API Base: $PUBLIC_URL/api/personas"
