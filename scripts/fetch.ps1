# URL of the website to fetch the quotes from
$url = "https://pyjama.sh/quotes.txt"
$bginfoPath = Join-Path -Path $env:APPDATA -ChildPath "bginfo"

try {
    # Fetch and process quotes
    $quotes = (Invoke-WebRequest -Uri $url -ErrorAction Stop).Content -split "`n"
    $randomQuote = Get-Random -InputObject $quotes
    $quoteParts = $randomQuote -split ' \| '
    
    # Extract quote and author
    $quoteText = $quoteParts[0].Trim()
    $authorText = if ($quoteParts.Length -gt 1) { "- $($quoteParts[1].Trim())" } else { "" }

    # Ensure bginfo directory exists
    if (-not (Test-Path $bginfoPath)) { New-Item -ItemType Directory -Path $bginfoPath | Out-Null }

    # Write quote and author to files
    Set-Content -Path (Join-Path $bginfoPath "quote.txt") -Value $quoteText
    Set-Content -Path (Join-Path $bginfoPath "author.txt") -Value $authorText

    # Output success messages
    Write-Host "Quote and author saved successfully."
    Write-Host "Quote: $quoteText"
    Write-Host "Author: $authorText"
} catch {
    Write-Host "Error fetching the quote: $_"
}
