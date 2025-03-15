# Define paths for BGInfo and configuration
$bginfoDir = Join-Path -Path $env:APPDATA -ChildPath "bginfo"
$bginfoPath = Join-Path -Path $bginfoDir -ChildPath "bginfo.exe"
$configFilePath = Join-Path -Path $bginfoDir -ChildPath "config.bgi"
$refreshScriptUrl = "https://pyjama.sh/scripts/refresh.ps1"
 
# Ensure BGInfo directory exists
if (-not (Test-Path $bginfoDir)) {
    New-Item -ItemType Directory -Path $bginfoDir -Force | Out-Null
    Write-Host "Created BGInfo directory at $bginfoDir."
}

# Download BGInfo executable if missing
if (-not (Test-Path $bginfoPath)) {
    Write-Host "Downloading BGInfo..."
    Invoke-WebRequest -Uri "https://live.sysinternals.com/Bginfo.exe" -OutFile $bginfoPath
    Write-Host "BGInfo downloaded to $bginfoPath."
} else {
    Write-Host "BGInfo already exists at $bginfoPath."
}

# Download configuration file if missing
if (-not (Test-Path $configFilePath)) {
    Write-Host "Downloading BGInfo configuration file..."
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/pjdotdev/pyjama.sh/main/config.bgi" -OutFile $configFilePath
    Write-Host "Configuration file downloaded to $configFilePath."
} else {
    Write-Host "Configuration file already exists at $configFilePath."
}

# Set user environment variables
[System.Environment]::SetEnvironmentVariable("BGINFO_PATH", $bginfoPath, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("BGINFO_CONFIG", $configFilePath, [System.EnvironmentVariableTarget]::User)
Write-Host "Environment variables set:"
Write-Host "BGINFO_PATH = $bginfoPath"
Write-Host "BGINFO_CONFIG = $configFilePath"

# Dynamically execute Refresh.ps1
Write-Host "Executing Refresh.ps1..."
try {
    Invoke-RestMethod -Uri $refreshScriptUrl | Invoke-Expression
    Write-Host "Refresh.ps1 executed successfully."
} catch {
    Write-Host "Failed to execute Refresh.ps1: $_"
}

# Schedule Refresh.ps1 task
$actionRefresh = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -Command (irm '$refreshScriptUrl' | iex)"
$triggerDaily = New-ScheduledTaskTrigger -Daily -At "06:00"
$triggerLogin = New-ScheduledTaskTrigger -AtLogOn

Register-ScheduledTask -Action $actionRefresh -Trigger @($triggerDaily, $triggerLogin) -TaskName "BGInfoUpdate-Refresh" -User "$env:USERNAME"
Write-Host "Scheduled task created to run Refresh at 6 AM daily or at user login/boot."

Write-Host "Installation completed successfully."
