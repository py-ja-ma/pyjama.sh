# Define paths for BGInfo and related files
$bginfoPath = [System.Environment]::GetEnvironmentVariable("BGINFO_PATH", [System.EnvironmentVariableTarget]::User)
$configFilePath = [System.Environment]::GetEnvironmentVariable("BGINFO_CONFIG", [System.EnvironmentVariableTarget]::User)
$bginfoDir = "$env:APPDATA\bginfo"
$filePaths = @(
    @{ Path = $bginfoPath; Name = "BGInfo executable" },
    @{ Path = $configFilePath; Name = "BGInfo configuration file" },
    @{ Path = "$bginfoDir\quote.txt"; Name = "quote.txt" },
    @{ Path = "$bginfoDir\author.txt"; Name = "author.txt" }
)
 
# Validate essential environment variables and paths
if (-Not $bginfoPath -or -Not $configFilePath) {
    Write-Host "BGInfo path or configuration file path is not set."
    Write-Host "Please run the setup script or set the environment variables manually."
    exit
}

# Check and report file paths
foreach ($file in $filePaths) {
    if (Test-Path $file.Path) {
        Write-Host "Found $($file.Name) at $($file.Path)."
    } elseif ($file.Name -eq "BGInfo executable" -or $file.Name -eq "BGInfo configuration file") {
        Write-Host "$($file.Name) not found at $($file.Path). Please check the path."
        exit
    } else {
        Write-Host "$($file.Name) not found at $($file.Path)."
    }
}

# Run BGInfo with the specified configuration file
Start-Process -FilePath $bginfoPath -ArgumentList "$configFilePath", "/timer:0"
Write-Host "BGInfo has been updated with the new configuration."
