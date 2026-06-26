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
    Remove-Item -Recurse -Force "hippo-memory"
    Write-Host "[OK] Carpeta hippo-memory eliminada." -ForegroundColor Green
}

$globalConfigPath = "$env:USERPROFILE\.gemini\config"
Write-Host "Eliminando configuraciones globales de $globalConfigPath..."
if (Test-Path "$globalConfigPath\mcp-config.json") {
    Remove-Item "$globalConfigPath\mcp-config.json" -Force
    Write-Host "[OK] Recurso global mcp-config.json eliminado." -ForegroundColor Green
}
if (Test-Path "$globalConfigPath\AGENTS.md") {
    Remove-Item "$globalConfigPath\AGENTS.md" -Force
    Write-Host "[OK] Recurso global AGENTS.md eliminado." -ForegroundColor Green
}
if (Test-Path "$globalConfigPath\.env") {
    Remove-Item "$globalConfigPath\.env" -Force
    Write-Host "[OK] Recurso global .env eliminado." -ForegroundColor Green
}
# Eliminar local mcp-config por si acaso quedó de una versión anterior
if (Test-Path "mcp-config.json") {
    Remove-Item "mcp-config.json" -Force
}

Write-Host "`n=========================================="
Write-Host " Rollback completado con éxito."
Write-Host "=========================================="
