# Source.ps1
# Refresh user environment variables
$envVars = [System.Environment]::GetEnvironmentVariables("User")
foreach ($key in $envVars.Keys) {
    $env:$key = $envVars[$key]
}

Write-Host "Environment variables refreshed."
