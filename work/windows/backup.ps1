param(
    [switch]$Backup,
    [switch]$Insert
)

if ($Backup) {
    # Backup Windows configs
    Copy-Item -Path "$env:USERPROFILE\.glzr" -Destination ".\work\windows\" -Recurse -Force
    Copy-Item -Path "$env:USERPROFILE\AppData\Local\nvim" -Destination ".\work\windows\" -Recurse -Force
    Write-Host "Backup complete: Windows configs saved to work/windows/"
}

if ($Insert) {
    # Insert Windows configs
    Copy-Item -Path ".\work\windows\.glzr" -Destination "$env:USERPROFILE\" -Recurse -Force
    Copy-Item -Path ".\work\windows\nvim" -Destination "$env:USERPROFILE\AppData\Local\" -Recurse -Force
    Write-Host "Insert complete: Windows configs restored from work/windows/"
}

if (-not $Backup -and -not $Insert) {
    Write-Host "Usage: .\backup.ps1 [-Backup] [-Insert]"
    Write-Host "  -Backup: Copy configs from system to repository"
    Write-Host "  -Insert: Copy configs from repository to system"
}
