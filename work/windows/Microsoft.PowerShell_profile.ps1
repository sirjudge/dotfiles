function GoHome { Set-Location $HOME }
Set-Alias -Name home -Value GoHome

function GoSol { Set-Location (Join-Path $HOME 'Solutions') }
Set-Alias -Name sol -Value GoSol

function GoApi { Set-Location (Join-Path $HOME 'Solutions\v3.Api') }
Set-Alias -Name api -Value GoApi

function GoUi { Set-Location (Join-Path $HOME 'Solutions\UI') }
Set-Alias -Name ui -Value GoUi

function GoAuth { Set-Location (Join-Path $HOME 'Solutions\Authorization') }
Set-Alias -Name auth -Value GoAuth
function ReloadPowershellProfile { . $Profile }
Set-Alias -Name reloadProfile -Value ReloadPowershellProfile

function EditProfile { nvim $PROFILE }
Set-Alias -Name epp -Value EditProfile

function LaunchLazyGit {
    $exe = Join-Path $HOME 'tools\lazygit\lazygit.exe'
        if (Test-Path $exe) { 
            & $exe 
        }
        else { 
            Write-Error "lazygit not found at $exe" 
        }
}
Set-Alias -Name lg -Value LaunchLazyGit 
Set-Alias -Name lazygit -Value LaunchLazyGit 

# oh-my-posh init (keep as you had it)
oh-my-posh --config ('~/Solutions/posh/sim-web.omp.json') init pwsh | Invoke-Expression
