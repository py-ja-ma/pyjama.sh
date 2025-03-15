# Define script URLs
$scripts = @(
    @{ Name = "Fetch.ps1"; Url = "https://pyjama.sh/scripts/fetch.ps1" },
    @{ Name = "Update.ps1"; Url = "https://pyjama.sh/scripts/update.ps1" }
)
 
# Dynamically fetch and execute each script
foreach ($script in $scripts) {
    Write-Host "Fetching and executing $($script.Name)..."
    try {
        Invoke-RestMethod -Uri $script.Url | Invoke-Expression
        Write-Host "$($script.Name) executed successfully."
    } catch {
        Write-Host "Failed to execute $($script.Name): $_"
    }
}
