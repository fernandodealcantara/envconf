# echo "Loading PowerShell profile..."
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Neovim\bin;")

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/wopian.omp.json" | Invoke-Expression

Import-Module posh-git

Import-Module ZLocation

# setup predictions
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView -Colors @{ InlinePrediction = $PSStyle.Background.Blue }

# log z-location
Write-Host -Foreground Green "`n[ZLocation] knows about $((Get-ZLocation).Keys.Count) locations.`n"
# alias z to z-location
Set-Alias -Name z -Value Invoke-ZLocation