# Update.ps1
# Define the paths for BGInfo and the configuration file
$bginfoPath = [System.Environment]::GetEnvironmentVariable("BGINFO_PATH", [System.EnvironmentVariableTarget]::User)
$configFilePath = [System.Environment]::GetEnvironmentVariable("BGINFO_CONFIG", [System.EnvironmentVariableTarget]::User)
$bginfoDir = "$env:APPDATA\bginfo"
$quoteFilePath = "$bginfoDir\quote.txt"
$authorFilePath = "$bginfoDir\author.txt"

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

# Check if quote.txt and author.txt exist
if (-Not (Test-Path $quoteFilePath)) {
    Write-Host "quote.txt not found at $quoteFilePath. Please check the path."
} else {
    Write-Host "Found quote.txt at $quoteFilePath."
}

if (-Not (Test-Path $authorFilePath)) {
    Write-Host "author.txt not found at $authorFilePath. Please check the path."
} else {
    Write-Host "Found author.txt at $authorFilePath."
}

# Run BGInfo with the specified configuration file
Start-Process -FilePath $bginfoPath -ArgumentList "$configFilePath", "/timer:0"

Write-Host "BGInfo has been updated with the new configuration."
