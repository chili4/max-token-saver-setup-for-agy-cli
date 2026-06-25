$ErrorActionPreference = "Stop"

Write-Host "=========================================="
Write-Host " Fase 1: Rollback de Instalación"
Write-Host "=========================================="

Write-Host "`n=========================================="
Write-Host " Fase 1: Rollback de Instalación"
Write-Host "=========================================="

Write-Host "Eliminando carpetas clonadas (RTK, Hippo Memory)..."
if (Test-Path "rtk") {
    Remove-Item -Recurse -Force "rtk"
    Write-Host "[OK] Carpeta rtk eliminada." -ForegroundColor Green
}
if (Test-Path "hippo-memory") {
    Remove-Item -Recurse -Force "hippo-memory"
    Write-Host "[OK] Carpeta hippo-memory eliminada." -ForegroundColor Green
}

Write-Host "Desinstalando code-scale-mcp de npm..."
npm uninstall -g @syphon1c/code-scale-mcp --silence
Write-Host "[OK] code-scale-mcp desinstalado si estaba presente." -ForegroundColor Green

Write-Host "Para context7-slim y Bifrost, revoca el acceso desde sus respectivos portales web." -ForegroundColor Yellow

if (Test-Path "mcp-config.json") {
    Remove-Item "mcp-config.json" -Force
    Write-Host "[OK] mcp-config.json eliminado." -ForegroundColor Green
}

Write-Host "`n=========================================="
Write-Host " Rollback completado con éxito."
Write-Host "=========================================="
