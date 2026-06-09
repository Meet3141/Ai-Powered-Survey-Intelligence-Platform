Write-Host "--- PHASE 2: CLEAN FILE SYSTEM ---" -ForegroundColor Cyan

$pathsToClean = @(
    "surveyclean-ai-copy/outputs",
    "agents/cleaning/outputs",
    "agent3-community-intelligence/inputs",
    "agent3-community-intelligence/outputs",
    "agents/clustering/inputs",
    "agents/clustering/outputs"
)

foreach ($path in $pathsToClean) {
    if (Test-Path $path) {
        Write-Host "Cleaning: $path"
        Get-ChildItem -Path $path -File | Where-Object { $_.Name -ne ".gitkeep" } | Remove-Item -Force
        Write-Host "Cleaned $path successfully." -ForegroundColor Green
    } else {
        Write-Host "Path not found: $path (Skipping)" -ForegroundColor Yellow
    }
}

Write-Host "Cleanup complete." -ForegroundColor Cyan
