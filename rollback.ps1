$ErrorActionPreference = "Stop"

Write-Host "=========================================="
Write-Host " Fase 1: Rollback de Instalación"
Write-Host "=========================================="

Write-Host "`n=========================================="
Write-Host " Fase 1: Rollback de Instalación"
Write-Host "=========================================="

Write-Host "Eliminando archivos (RTK, Hippo Memory)..."
if (Get-Command "cargo" -ErrorAction SilentlyContinue) {
    $rtkExe = "$env:USERPROFILE\.cargo\bin\rtk.exe"
} else {
    $rtkExe = "C:\Windows\System32\rtk.exe"
}
if (Test-Path $rtkExe) {
    Remove-Item $rtkExe -Force
    Write-Host "[OK] RTK ($rtkExe) eliminado." -ForegroundColor Green
}
if (Test-Path "hippo-memory") {
    if (Get-Command "pm2" -ErrorAction SilentlyContinue) {
        Write-Host "Deteniendo servicio de Hippo Memory..."
        pm2 delete hippo-memory -s | Out-Null
        pm2 save -s | Out-Null
    }
    Remove-Item -Recurse -Force "hippo-memory"
    Write-Host "[OK] Carpeta hippo-memory eliminada y servicio detenido." -ForegroundColor Green
}

$globalConfigPath = "$env:USERPROFILE\.gemini\config"
Write-Host "Eliminando configuraciones globales de $globalConfigPath..."
$filesToRemove = @("mcp-config.json", "AGENTS.md", ".env", "bifrost")
foreach ($f in $filesToRemove) {
    if (Test-Path "$globalConfigPath\$f") {
        Remove-Item "$globalConfigPath\$f" -Recurse -Force
        Write-Host "[OK] Recurso global $f eliminado." -ForegroundColor Green
    }
}
# Eliminar local mcp-config por si acaso quedó de una versión anterior
if (Test-Path "mcp-config.json") {
    Remove-Item "mcp-config.json" -Force
}

Write-Host "`n=========================================="
Write-Host " Rollback completado con éxito."
Write-Host "=========================================="
