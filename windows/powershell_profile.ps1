# Set oh-my-posh theme to zash
Set-PoshPrompt -Theme zash

# Create a new empty file in the current working directory
function touch ([string] $fileName) {
    if (!(Test-Path $fileName)) {
        Write-Host "Creating $fileName"
        New-Item -Path . -Name $fileName -ItemType File
    }
}

# Reload powershell profile
function reload {
    . $PROFILE
    & $PROFILE
}

# Create a signed commit with given message
function commit ([string] $commitMessage) {
    git commit --all -S -s -am $commitMessage
}

# Show oneline log of commits of given size
function lg ([int] $logSize) {
    git log --oneline -n $logSize
}

# List all files inside current working directory
function ls { Get-Item * }

# Push changes to github repository
function push { git push }

# Show the status of files in the current working directory
function st { git status }
