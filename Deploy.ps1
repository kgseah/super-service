# Deploy.ps1
param(
    [string]$ComposeFile = "docker-compose.yml"
)

# Function to print messages with timestamps
function Write-Log {
    param (
        [string]$Message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "$timestamp - $Message"
}

# Build Docker images
Write-Log "Building Docker images..."
docker-compose -f $ComposeFile build
if ($LASTEXITCODE -ne 0) {
    Write-Log "Docker build failed."
    exit $LASTEXITCODE
}

# Start Docker containers
Write-Log "Starting Docker containers..."
docker-compose -f $ComposeFile up -d
if ($LASTEXITCODE -ne 0) {
    Write-Log "Failed to start Docker containers."
    exit $LASTEXITCODE
}

Write-Log "Docker containers are up and running."

# Optional: Show logs
Write-Log "Showing Docker logs..."
docker-compose -f $ComposeFile logs -f

# Optional: Cleanup resources (uncomment if needed)
# Write-Log "Stopping Docker containers..."
# docker-compose -f $ComposeFile down
# if ($LASTEXITCODE -ne 0) {
#     Write-Log "Failed to stop Docker containers."
#     exit $LASTEXITCODE
# }

Write-Log "Deployment script completed."
