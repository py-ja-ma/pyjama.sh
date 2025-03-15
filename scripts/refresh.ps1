# Refresh.ps1
# Dynamically run Fetch.ps1
Write-Host "Fetching and executing Fetch.ps1..."
try {
    Invoke-RestMethod -Uri "https://pyjama.sh/scripts/fetch.ps1" | Invoke-Expression
    Write-Host "Fetch.ps1 executed successfully."
} catch {
    Write-Host "Failed to execute Fetch.ps1: $_"
}

# Dynamically run Update.ps1
Write-Host "Fetching and executing Update.ps1..."
try {
    Invoke-RestMethod -Uri "https://pyjama.sh/scripts/update.ps1" | Invoke-Expression
    Write-Host "Update.ps1 executed successfully."
} catch {
    Write-Host "Failed to execute Update.ps1: $_"
}