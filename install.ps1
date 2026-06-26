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
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
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
if (Test-Path "hippo-memory\package.json") {
    if (Get-Command "npm" -ErrorAction SilentlyContinue) {
        Write-Host "Instalando dependencias de Node para Hippo Memory..."
        Set-Location hippo-memory
        npm install
        
        Write-Host "Configurando Hippo Memory para ejecución automática en segundo plano (PM2)..."
        if (-Not (Get-Command "pm2" -ErrorAction SilentlyContinue)) {
            npm install -g pm2
        }
        pm2 start npm --name "hippo-memory" -- start
        pm2 save
        Set-Location ..
    } else {
        Write-Host "[WARN] 'npm' no está instalado. Instala Node.js para poder usar Hippo Memory." -ForegroundColor Yellow
    }
}

Write-Host "Configurando mcp-config.json Gateway y Reglas Globales..."
$globalConfigPath = "$env:USERPROFILE\.gemini\config"
if (-Not (Test-Path $globalConfigPath)) {
    New-Item -ItemType Directory -Force -Path $globalConfigPath | Out-Null
}

Write-Host "Instalando Bifrost de manera local..."
$bifrostPath = "$globalConfigPath\bifrost"
if (-Not (Test-Path $bifrostPath)) {
    git clone https://github.com/maximhq/bifrost.git $bifrostPath
}
if (Test-Path "$bifrostPath\package.json") {
    if (Get-Command "npm" -ErrorAction SilentlyContinue) {
        Write-Host "Instalando dependencias de Bifrost..."
        Set-Location $bifrostPath
        npm install
        Set-Location $PSScriptRoot
    }
}

$mcpConfig = @{
    mcpServers = @{
        bifrost = @{
            command = "node"
            args = @("$bifrostPath\bifrost-gateway.js")
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
# Instalar mcp-config.json globalmente
$mcpConfig | ConvertTo-Json -Depth 5 | Out-File -FilePath "$globalConfigPath\mcp-config.json" -Encoding UTF8
Write-Host "[OK] Gateway configurado GLOBALMENTE en $globalConfigPath\mcp-config.json" -ForegroundColor Green

# Instalar AGENTS.md globalmente
if (Test-Path ".agents\AGENTS.md") {
    Copy-Item ".agents\AGENTS.md" -Destination "$globalConfigPath\AGENTS.md" -Force
    Write-Host "[OK] Directiva Superpowers instalada GLOBALMENTE en $globalConfigPath\AGENTS.md" -ForegroundColor Green
}

# Instalar .env globalmente
if (Test-Path ".env") {
    Copy-Item ".env" -Destination "$globalConfigPath\.env" -Force
    Write-Host "[OK] Archivo .env detectado e instalado GLOBALMENTE." -ForegroundColor Green
} else {
    Write-Host "[INFO] No se encontró un archivo .env en la raíz. Recuerda crear $globalConfigPath\.env con tu API Key de Context7." -ForegroundColor Cyan
}

Write-Host "`n=========================================="
Write-Host " Instalación completada con éxito."
Write-Host "=========================================="
