# Update.ps1
# Check if the environment variables are set
$bginfoPath = [System.Environment]::GetEnvironmentVariable("BGINFO_PATH", [System.EnvironmentVariableTarget]::User)
$configFilePath = [System.Environment]::GetEnvironmentVariable("BGINFO_CONFIG", [System.EnvironmentVariableTarget]::User)

# Check if the environment variables are not set
if (-Not $bginfoPath -or -Not $configFilePath) {
    Write-Host "BGInfo path or configuration file path is not set."
    Write-Host "Please run the setup script to configure BGInfo or set the environment variables manually."
    exit
}

# Check if BGInfo is installed
if (-Not (Test-Path $bginfoPath)) {
    Write-Host "BGInfo not found at $bginfoPath. Please check the path."
    exit
}

# Check if the configuration file exists
if (-Not (Test-Path $configFilePath)) {
    Write-Host "BGInfo configuration file not found at $configFilePath. Please check the path."
    exit
}

# Run BGInfo with the specified configuration file
Start-Process -FilePath $bginfoPath -ArgumentList "$configFilePath", "/timer:0"

Write-Host "BGInfo has been refreshed with the new configuration."

try {
    # Refresh user environment variables
    $envVars = [System.Environment]::GetEnvironmentVariables("User")
    foreach ($key in $envVars.Keys) {
        $env:$key = $envVars[$key]
    }
    Write-Host "User environment variables refreshed."
} catch {
    Write-Host "Error refreshing environment variables: $_"
}
