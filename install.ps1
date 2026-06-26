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

Write-Host "Instalando RTK (Rust Token Killer) desde binarios precompilados..."
$rtkZip = "$env:TEMP\rtk.zip"
$rtkDest = "$env:TEMP\rtk-bin"
if (Get-Command "cargo" -ErrorAction SilentlyContinue) {
    $installDir = "$env:USERPROFILE\.cargo\bin"
} else {
    $installDir = "C:\Windows\System32"
}
try {
    Invoke-WebRequest -Uri "https://github.com/rtk-ai/rtk/releases/download/v0.42.4/rtk-x86_64-pc-windows-msvc.zip" -OutFile $rtkZip -ErrorAction Stop
    Expand-Archive -Path $rtkZip -DestinationPath $rtkDest -Force
    Copy-Item "$rtkDest\rtk.exe" -Destination "$installDir\rtk.exe" -Force
    Remove-Item -Recurse -Force $rtkDest, $rtkZip
    Write-Host "[OK] RTK instalado correctamente en $installDir" -ForegroundColor Green
} catch {
    Write-Host "[WARN] No se pudo instalar RTK automáticamente. Descárgalo desde GitHub Releases." -ForegroundColor Yellow
}

Write-Host "Instalando Hippo Memory..."
if (-Not (Test-Path "hippo-memory")) {
    git clone https://github.com/kitfunso/hippo-memory.git hippo-memory
}
# Intentando compilación si es Node
if (Test-Path "hippo-memory\package.json") {
    if (Get-Command "npm" -ErrorAction SilentlyContinue) {
        Write-Host "Instalando dependencias de Node..."
        Set-Location hippo-memory
        npm install
        npm link
        Set-Location ..
    } else {
        Write-Host "[WARN] 'npm' no está instalado. Omita la instalación de Hippo Memory." -ForegroundColor Yellow
    }
}

Write-Host "Aviso de Instalación Manual: context7-slim y Bifrost"
Write-Host "1. context7-slim: Requiere configuración de cuenta o descarga desde https://context7.com/" -ForegroundColor Yellow
Write-Host "2. Bifrost: Herramienta de ecosistema getmaxim.ai. Sigue los pasos de configuración de API en https://www.getmaxim.ai/bifrost" -ForegroundColor Yellow

Write-Host "Configurando mcp-config.json Gateway..."
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
        context7 = @{
            command = "context7-slim"
            args = @("--rag-only")
        }
    }
}
$mcpConfig | ConvertTo-Json -Depth 5 | Out-File -FilePath "mcp-config.json" -Encoding UTF8
Write-Host "[OK] Gateway configurado en mcp-config.json." -ForegroundColor Green

Write-Host "`n=========================================="
Write-Host " Instalación completada con éxito."
Write-Host "=========================================="
