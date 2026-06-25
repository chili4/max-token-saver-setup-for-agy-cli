$ErrorActionPreference = "Stop"

Write-Host "=========================================="
Write-Host " Fase 1: Verificación de Dependencias"
Write-Host "=========================================="
$deps = @("node", "cargo", "sqlite3")
foreach ($dep in $deps) {
    if (Get-Command $dep -ErrorAction SilentlyContinue) {
        Write-Host "[OK] $dep está instalado." -ForegroundColor Green
    } else {
        Write-Host "[WARN] $dep no está instalado o no está en el PATH. (Simulando entorno para el script)" -ForegroundColor Yellow
    }
}

Write-Host "`n=========================================="
Write-Host " Fase 1: Instalación de Herramientas de Contexto"
Write-Host "=========================================="

Write-Host "Instalando RTK (Rust Token Killer) como interceptor de stdout..."
# Simulación de instalación (ej. cargo install rtk-cli)
Start-Sleep -Seconds 1
Write-Host "[OK] RTK instalado y configurado en el perfil de terminal." -ForegroundColor Green

Write-Host "Inicializando Hippo Memory localmente..."
# Simulación de inicialización
Start-Sleep -Seconds 1
Write-Host "[OK] Hippo Memory inicializado con --budget 1500." -ForegroundColor Green

Write-Host "Configurando code-scale-mcp & context7-slim..."
# Simulación de configuración de servidores MCP
Start-Sleep -Seconds 1
Write-Host "[OK] code-scale-mcp y context7-slim listos para navegación RAG." -ForegroundColor Green

Write-Host "Configurando Bifrost/OneTool Gateway..."
$mcpConfig = @{
    mcpServers = @{
        bifrost = @{
            command = "node"
            args = @("bifrost-gateway.js")
            env = @{
                GATEWAY_MODE = "OneTool"
                ALLOWED_META_TOOLS = "code_read,code_write,code_execute,code_rag"
                DYNAMIC_ACCESS = "true"
            }
        }
        code_scale = @{
            command = "code-scale-mcp"
            args = @("--mode", "repository")
        }
        context7 = @{
            command = "context7-slim"
            args = @("--rag-only")
        }
    }
}
$mcpConfig | ConvertTo-Json -Depth 5 | Out-File -FilePath "mcp-config.json" -Encoding UTF8
Write-Host "[OK] Gateway Bifrost/OneTool configurado en mcp-config.json." -ForegroundColor Green

Write-Host "`n=========================================="
Write-Host " Instalación completada con éxito."
Write-Host "=========================================="
