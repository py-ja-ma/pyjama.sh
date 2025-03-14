# fetch.ps1

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
    $quoteParts = $randomQuote -split ' – '
    $quoteText = $quoteParts[0].Trim()
    $authorText = if ($quoteParts.Length -gt 1) { "— $($quoteParts[1].Trim())" 
    } else { "" }

    # Create unique variable names using the current user's name and a timestamp
    $quoteVarName = "BGINFO_QUOTE"
    $authorVarName = "BGINFO_AUTHOR"

    # Set the environment variables
    [System.Environment]::SetEnvironmentVariable($quoteVarName, $quoteText, [System.EnvironmentVariableTarget]::User)
    [System.Environment]::SetEnvironmentVariable($authorVarName, $authorText, [System.EnvironmentVariableTarget]::User)

    Write-Host "Quote fetched and saved successfully."
    Write-Host "Quote: $quoteText"
    Write-Host "Author: $authorText"
    Write-Host "Stored in variables: $quoteVarName and $authorVarName"
} catch {
    Write-Host "An error occurred while fetching the quote: $_"
}
