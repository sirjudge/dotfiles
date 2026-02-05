param(
    [switch]$Backup,
    [switch]$Insert,
    [switch]$Verbose
)

if (-not $Backup -and -not $Insert) {
    Write-Host "Usage: .\backup.ps1 [-Backup] [-Insert] [-Work]"
    Write-Host "  -Backup: Backup configurations to dotfiles"
    Write-Host "  -Insert: Insert/restore configurations from dotfiles"
    exit 1
}

if ($Backup) {
    rm -r ./work

    Copy-Item -Path "$env:USERPROFILE\.config\nvim" -Destination ".\work\nvim" -Recurse -Force
    if ($Verbose) { Write-Host "Backed up nvim config to .\work\" }

    Copy-Item -Path "$env:USERPROFILE\.glzr" -Destination ".\work\.glzr\" -Recurse -Force
    if ($Verbose) { Write-Host "Backed up glzr config to .\work\" }

    Copy-Item -Path "$env:USERPROFILE\.wezterm.lua" -Destination ".\work\.wezterm.lua" -Recurse -Force
    if ($Verbose) { Write-Host "Backed up wezterm config to .\work\" }

    Copy-Item -Path "~/Solutions/powershell/PowerShell/Microsoft.PowerShell_profile.ps1" -Destination ".\work\Microsoft.PowerShell_profile.ps1" -Recurse -Force
    Copy-Item -Path "~/Solutions/powershell/PowerShell/ZoxideInit.ps1" -Destination ".\work\Microsoft.PowerShell_profile.ps1" -Recurse -Force
    if ($Verbose) { Write-Host "Backed up PowerShell profile to .\work\" }

    Write-Host "Backed up Windows work configs (.glzr, nvim)"
}

if ($Insert) {
    Copy-Item -Path ".\work\nvim" -Destination "$env:USERPROFILE\.config\nvim" -Recurse -Force
    if ($Verbose) { Write-Host "Inserted nvim config to $env:USERPROFILE\.config\nvim" }

    Copy-Item -Path ".\work\windows\.glzr" -Destination "$env:USERPROFILE\.glzr" -Recurse -Force
    if ($Verbose) { Write-Host "Inserted glzr config to $env:USERPROFILE\.glzr" }

    if ($Verbose) { Write-Host "Inserted Windows work configs (.glzr, nvim)" }
}
