# Uninstall.ps1
# Define the paths for BGInfo and the configuration file
$bginfoDir = "$env:APPDATA\bginfo"
$bginfoPath = "$bginfoDir\bginfo.exe"
$configFilePath = "$bginfoDir\config.bgi"
$quoteFilePath = "$bginfoDir\quote.txt"
$authorFilePath = "$bginfoDir\author.txt"
$taskName = "BGInfoUpdate"
$variablesToRemove = @("BGINFO_PATH", "BGINFO_CONFIG")

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

# Remove quote.txt and author.txt files if they exist
if (Test-Path $quoteFilePath) {
    Remove-Item -Path $quoteFilePath -Force
    Write-Host "Removed quote.txt at $quoteFilePath."
} else {
    Write-Host "quote.txt not found at $quoteFilePath."
}

if (Test-Path $authorFilePath) {
    Remove-Item -Path $authorFilePath -Force
    Write-Host "Removed author.txt at $authorFilePath."
} else {
    Write-Host "author.txt not found at $authorFilePath."
}

# Remove registered scheduled tasks for Fetch and Update
$scheduleTasks = @("$taskName-Fetch", "$taskName-Update")
foreach ($task in $scheduleTasks) {
    try {
        Unregister-ScheduledTask -TaskName $task -Confirm:$false -ErrorAction Stop
        Write-Host "Removed scheduled task: $task."
    } catch {
        Write-Host "Scheduled task $task not found or could not be removed."
    }
}

# Remove the entire BGInfo directory if it is empty
if (Test-Path $bginfoDir) {
    Remove-Item -Path $bginfoDir -Recurse -Force
    Write-Host "Removed BGInfo directory at $bginfoDir."
} else {
    Write-Host "BGInfo directory not found at $bginfoDir."
}

# Set the desktop background color to black
# Define the path for the black bitmap image
$blackImagePath = "$env:TEMP\black.bmp"

# Create a 1x1 black bitmap image
Add-Type -AssemblyName System.Drawing
$bitmap = New-Object System.Drawing.Bitmap(1, 1)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.Clear([System.Drawing.Color]::Black)
$bitmap.Save($blackImagePath, [System.Drawing.Imaging.ImageFormat]::Bmp)
$graphics.Dispose()
$bitmap.Dispose()

# Set the desktop wallpaper to the black image
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value $blackImagePath

# Update the wallpaper style (0 = Center, 1 = Tile, 2 = Stretch)
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name WallpaperStyle -Value 2
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name TileWallpaper -Value 0

# Update the desktop to apply the changes
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
[Wallpaper]::SystemParametersInfo(20, 0, $blackImagePath, 3)

# Clean up the bitmap file if needed
Remove-Item $blackImagePath -Force

Write-Host "Desktop background color set to black."

# Remove user-level environment variables
foreach ($var in $variablesToRemove) {
    [System.Environment]::SetEnvironmentVariable($var, $null, "User")
    Write-Host "Removed user-level environment variable: $var."
}

Write-Host "Uninstallation process completed."
