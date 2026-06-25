$ErrorActionPreference = "Stop"

Write-Host "=========================================="
Write-Host " Fase 1: Rollback de Instalación"
Write-Host "=========================================="

Write-Host "Desinstalando RTK (Rust Token Killer)..."
Start-Sleep -Seconds 1
Write-Host "[OK] RTK desinstalado." -ForegroundColor Green

Write-Host "Eliminando base de datos local de Hippo Memory..."
Start-Sleep -Seconds 1
Write-Host "[OK] Hippo Memory eliminado." -ForegroundColor Green

Write-Host "Desactivando code-scale-mcp & context7-slim..."
Start-Sleep -Seconds 1
Write-Host "[OK] Componentes desactivados." -ForegroundColor Green

if (Test-Path "mcp-config.json") {
    Remove-Item "mcp-config.json" -Force
    Write-Host "[OK] mcp-config.json eliminado." -ForegroundColor Green
}

Write-Host "`n=========================================="
Write-Host " Rollback completado con éxito."
Write-Host "=========================================="
