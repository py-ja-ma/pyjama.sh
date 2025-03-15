# Uninstall.ps1
# Define the paths for BGInfo and the configuration file
$bginfoDir = "$env:APPDATA\bginfo"
$bginfoPath = "$bginfoDir\bginfo.exe"
$configFilePath = "$bginfoDir\config.bgi"
$taskName = "BGInfoUpdate"

# Remove the BGInfo executable and configuration file if they exist
if (Test-Path $bginfoPath) {
    Remove-Item -Path $bginfoPath -Force
    Write-Host "Removed BGInfo executable at $bginfoPath."
} else {
    Write-Host "BGInfo executable not found at $bginfoPath."
}

if (Test-Path $configFilePath) {
    Remove-Item -Path $configFilePath -Force
    Write-Host "Removed BGInfo configuration file at $configFilePath."
} else {
    Write-Host "BGInfo configuration file not found at $configFilePath."
}

# Remove registered scheduled tasks
try {
    Unregister-ScheduledTask -TaskName "$taskName-Fetch" -Confirm:$false -ErrorAction Stop
    Write-Host "Removed scheduled task: $taskName-Fetch."
} catch {
    Write-Host "Scheduled task $taskName-Fetch not found."
}

try {
    Unregister-ScheduledTask -TaskName "$taskName-Refresh" -Confirm:$false -ErrorAction Stop
    Write-Host "Removed scheduled task: $taskName-Refresh."
} catch {
    Write-Host "Scheduled task $taskName-Refresh not found."
}

# Remove the entire BGInfo directory if it is empty
if (Test-Path $bginfoDir) {
    Remove-Item -Path $bginfoDir -Recurse -Force
    Write-Host "Removed BGInfo directory at $bginfoDir."
} else {
    Write-Host "BGInfo directory not found at $bginfoDir."
}

# Set the desktop background color to black
$blackColor = 0x000000  # RGB value for black
Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name Background -Value "$blackColor"
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

Write-Host "Desktop background color set to black."

# Remove environment variables
[System.Environment]::SetEnvironmentVariable("BGINFO_PATH", $null, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("BGINFO_CONFIG", $null, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("BGINFO_QUOTE", $null, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("BGINFO_AUTHOR", $null, [System.EnvironmentVariableTarget]::User)

Write-Host "Environment variables removed."
