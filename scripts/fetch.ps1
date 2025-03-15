# Fetch.ps1
# URL of the website to fetch the quote from
$url = "https://pyjama.sh/quotes.txt"

try {
    # Fetch the quotes from the text file
    $response = Invoke-WebRequest -Uri $url -ErrorAction Stop

    # Split the response into an array of quotes
    $quotes = $response.Content -split "`n"

    # Select a random quote
    $randomQuote = Get-Random -InputObject $quotes

    # Split the quote into text and author
    $quoteParts = $randomQuote -split ' \| '
    $quoteText = $quoteParts[0].Trim()
    $authorText = if ($quoteParts.Length -gt 1) { "- $($quoteParts[1].Trim())" } else { "" }

    # Define the path for the bginfo directory
    $bginfoPath = Join-Path -Path $env:APPDATA -ChildPath "bginfo"

    # Create the bginfo directory if it doesn't exist
    if (-not (Test-Path -Path $bginfoPath)) {
        New-Item -ItemType Directory -Path $bginfoPath | Out-Null
    }

    # Write the quote to quote.txt
    $quoteFilePath = Join-Path -Path $bginfoPath -ChildPath "quote.txt"
    Set-Content -Path $quoteFilePath -Value $quoteText

    # Write the author to author.txt
    $authorFilePath = Join-Path -Path $bginfoPath -ChildPath "author.txt"
    Set-Content -Path $authorFilePath -Value $authorText

    Write-Host "Quote and author have been saved successfully."
    Write-Host "Quote: $quoteText"
    Write-Host "Author: $authorText"
} catch {
    Write-Host "An error occurred while fetching the quote: $_"
}
