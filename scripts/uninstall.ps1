# Uninstall.ps1
# Define the paths for BGInfo and the configuration file
$bginfoDir = "$env:APPDATA\bginfo"
$bginfoPath = "$bginfoDir\bginfo.exe"
$configFilePath = "$bginfoDir\config.bgi"

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

# Remove the entire BGInfo directory if it is empty
if (Test-Path $bginfoDir) {
    Remove-Item -Path $bginfoDir -Recurse -Force
    Write-Host "Removed BGInfo directory at $bginfoDir."
} else {
    Write-Host "BGInfo directory not found at $bginfoDir."
}

# Reset the desktop background to the default Windows wallpaper
$defaultWallpaperPath = "C:\Windows\Web\Wallpaper\Windows\img0.jpg"  # Default Windows wallpaper path
if (Test-Path $defaultWallpaperPath) {
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $defaultWallpaperPath
    RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
    Write-Host "Desktop background reset to default."
} else {
    Write-Host "Default wallpaper not found at $defaultWallpaperPath."
}

# Remove environment variables
[System.Environment]::SetEnvironmentVariable("BGINFO_PATH", $null, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("BGINFO_CONFIG", $null, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("BGINFO_QUOTE", $null, [System.EnvironmentVariableTarget]::User)
[System.Environment]::SetEnvironmentVariable("BGINFO_AUTHOR", $null, [System.EnvironmentVariableTarget]::User)

Write-Host "Environment variables removed."
