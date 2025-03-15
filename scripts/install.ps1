# Install.ps1
# Define the paths for BGInfo and the configuration file
$bginfoDir = "$env:APPDATA\bginfo"
$bginfoPath = "$bginfoDir\bginfo.exe"
$configFilePath = "$bginfoDir\config.bgi"

# Create the directory if it doesn't exist
if (-Not (Test-Path $bginfoDir)) {
    New-Item -ItemType Directory -Path $bginfoDir -Force
}

# Download BGInfo if it doesn't exist
if (-Not (Test-Path $bginfoPath)) {
    Write-Host "Downloading BGInfo from https://live.sysinternals.com/Bginfo.exe..."
    Invoke-WebRequest -Uri "https://live.sysinternals.com/Bginfo.exe" -OutFile $bginfoPath
    Write-Host "BGInfo downloaded to $bginfoPath."
} else {
    Write-Host "BGInfo already exists at $bginfoPath."
}

# Check if the configuration file exists
if (-Not (Test-Path $configFilePath)) {
    Write-Host "BGInfo configuration file not found at $configFilePath. Downloading from GitHub..."
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/pjdotdev/pyjama.sh/main/config.bgi" -OutFile $configFilePath
    Write-Host "Configuration file downloaded to $configFilePath."
} else {
    Write-Host "BGInfo configuration file already exists at $configFilePath."
}

# Set the environment variables
[System.Environment]::SetEnvironmentVariable("BGINFO_PATH", $bginfoPath, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("BGINFO_CONFIG", $configFilePath, [System.EnvironmentVariableTarget]::User)

Write-Host "Environment variables set:"
Write-Host "BGINFO_PATH = $bginfoPath"
Write-Host "BGINFO_CONFIG = $configFilePath"

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

Write-Host "Installation complete. Fetch and Update scripts have been executed."

# Define the URLs for Fetch and Update scripts
$fetchScriptUrl = "https://pyjama.sh/scripts/fetch.ps1"
$updateScriptUrl = "https://pyjama.sh/scripts/update.ps1"

# Create scheduled tasks for Fetch and Update
$actionFetch = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -Command (irm '$fetchScriptUrl' | iex)"
$actionUpdate = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -Command (irm '$updateScriptUrl' | iex)"

$triggerFetch = New-ScheduledTaskTrigger -Daily -At "06:00"
$triggerUpdate = New-ScheduledTaskTrigger -AtLogOn

# Register the scheduled tasks
Register-ScheduledTask -Action $actionFetch -Trigger $triggerFetch -TaskName "BGInfoUpdate-Fetch" -User "$env:USERNAME"
Register-ScheduledTask -Action $actionUpdate -Trigger $triggerUpdate -TaskName "BGInfoUpdate-Update" -User "$env:USERNAME"

Write-Host "Scheduled tasks created to run Fetch at 6 AM daily and Update at user login."

