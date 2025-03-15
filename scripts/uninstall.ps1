# Ensure BGInfo is not running
Write-Host "Checking if BGInfo is running..."
try {
    Get-Process -Name "bginfo" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction Stop
    Write-Host "Stopped BGInfo processes."
} catch {
    Write-Host "No running BGInfo processes or failed to stop them: $_"
}

Write-Host "Proceeding with uninstallation..."

# Define paths and variables
$bginfoDir = "$env:APPDATA\bginfo"
$filePaths = @(
    @{ Path = "$bginfoDir\bginfo.exe"; Name = "BGInfo executable" },
    @{ Path = "$bginfoDir\config.bgi"; Name = "BGInfo configuration file" },
    @{ Path = "$bginfoDir\quote.txt"; Name = "quote.txt" },
    @{ Path = "$bginfoDir\author.txt"; Name = "author.txt" }
)
$taskName = "BGInfoUpdate-Refresh"
$variablesToRemove = @("BGINFO_PATH", "BGINFO_CONFIG")

# Remove files
foreach ($file in $filePaths) {
    if (Test-Path $file.Path) {
        Remove-Item -Path $file.Path -Force
        Write-Host "Removed $($file.Name) at $($file.Path)."
    } else {
        Write-Host "$($file.Name) not found."
    }
}

# Unregister scheduled task
try {
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction Stop
        Write-Host "Removed scheduled task: $taskName."
    } else {
        Write-Host "Scheduled task $taskName not found."
    }
} catch {
    Write-Host "Could not remove scheduled task $taskName: $($_)"
}

# Remove BGInfo directory if it exists
if (Test-Path $bginfoDir) {
    Remove-Item -Path $bginfoDir -Recurse -Force
    Write-Host "Removed BGInfo directory at $bginfoDir."
} else {
    Write-Host "BGInfo directory not found."
}

# Set desktop background color to black
$blackImagePath = "$env:TEMP\black.bmp"
try {
    Add-Type -AssemblyName System.Drawing
    $bitmap = New-Object System.Drawing.Bitmap(1, 1)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.Clear([System.Drawing.Color]::Black)
    $bitmap.Save($blackImagePath, [System.Drawing.Imaging.ImageFormat]::Bmp)
    $graphics.Dispose()
    $bitmap.Dispose()

    # Update wallpaper settings
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value $blackImagePath
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name WallpaperStyle -Value 2
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name TileWallpaper -Value 0
 
    # Refresh desktop
    Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@
    [Wallpaper]::SystemParametersInfo(20, 0, $blackImagePath, 3)

    # Clean up temporary file
    Remove-Item $blackImagePath -Force
    Write-Host "Desktop background set to black."
} catch {
    Write-Host "Failed to update desktop background: $_"
}

# Remove user-level environment variables
foreach ($var in $variablesToRemove) {
    [System.Environment]::SetEnvironmentVariable($var, $null, "User")
    Write-Host "Removed user-level environment variable: $var."
}

Write-Host "Uninstallation process completed."
