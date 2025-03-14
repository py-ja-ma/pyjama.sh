# fetch.ps1

# URL of the website to fetch the quote from
$url = "https://pyjama.sh/quotes.txt"

# Fetch the quotes from the text file
$response = Invoke-WebRequest -Uri $quotesUrl

# Split the response into an array of quotes
$quotes = $response.Content -split "`n"

# Select a random quote
$randomQuote = Get-Random -InputObject $quotes

# Split the quote into text and author
$quoteParts = $randomQuote -split ' – '
$quoteText = $quoteParts[0].Trim()
$authorText = if ($quoteParts.Length -gt 1) { "— $($quoteParts[1].Trim())" } else { "" }

# Create a text file to store the quote
$quoteOutput = "$quoteText $authorText"
Set-Content -Path "$env:USERPROFILE\quote.txt" -Value $quoteOutput
