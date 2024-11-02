# Define the location of the .env file (change if needed)
$envFile = "./auth-service/.env"

# Check if the .env file exists
if (!(Test-Path $envFile)) {
    Write-Error ".env file not found!"
    exit 1
}

# Read each line in the .env file (ignoring comments)
Get-Content $envFile | Where-Object { $_ -notmatch '^#' -and $_ } | ForEach-Object {
    # Split the line into key and value
    $key, $value = $_.Split('=', 2)

    # Export the variable using Set-Item
    Set-Item Env:$key $value
}

# Run docker-compose commands with exported variables
docker compose build
docker compose up
