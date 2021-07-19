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
    if ($commitMessage -ne "") {
        git commit --all -S -s -am $commitMessage
    } else {
        Write-Host "Aborting! No commit message provided."
    }
}

# Show oneline log of commits of given size
function lg ([int] $logSize) {
    if ($logSize -le 0) {
        $logSize = 10
        Write-Host "Using default log size of $logSize"
    }
    git log --oneline -n $logSize
}

# List all files inside current working directory
function ls { Get-Item * }

# Push changes to github repository
function push { git push }

# Force Push changes to github repository
function fpush { git push -f }

# Show the status of files in the current working directory
function st { git status }
