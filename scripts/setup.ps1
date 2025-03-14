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
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/yourusername/yourrepo/main/pyjama.sh/config.bgi" -OutFile $configFilePath
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

# Define the paths for the fetch and refresh scripts
$fetchScriptUrl = "https://pyjama.sh/fetch.ps1"
$refreshScriptUrl = "https://pyjama.sh/refresh.ps1"
$taskName = "BGInfoUpdate"

# Create a scheduled task to run the fetch and refresh scripts at user login
$actionFetch = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$fetchScriptUrl`""
$actionRefresh = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$refreshScriptUrl`""

$trigger = New-ScheduledTaskTrigger -AtLogOn

# Register the scheduled task
Register-ScheduledTask -Action $actionFetch -Trigger $trigger -TaskName "$taskName-Fetch" -User "$env:USERNAME" -RunLevel Highest
Register-ScheduledTask -Action $actionRefresh -Trigger $trigger -TaskName "$taskName-Refresh" -User "$env:USERNAME" -RunLevel Highest

Write-Host "Scheduled tasks created to run fetch and refresh scripts at user login."