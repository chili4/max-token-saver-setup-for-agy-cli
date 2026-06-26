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

Write-Host "Para context7-slim y Bifrost, revoca el acceso desde sus respectivos portales web." -ForegroundColor Yellow

if (Test-Path "mcp-config.json") {
    Remove-Item "mcp-config.json" -Force
    Write-Host "[OK] mcp-config.json eliminado." -ForegroundColor Green
}

Write-Host "`n=========================================="
Write-Host " Rollback completado con éxito."
Write-Host "=========================================="
