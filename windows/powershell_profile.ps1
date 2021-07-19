# Set oh-my-posh theme to zash
Set-PoshPrompt -Theme zash

# Create a new empty file in the current working directory
function touch ([string] $fileName) {
    if (!(Test-Path $fileName)) {
        Write-Host "Creating $fileName"
        New-Item -Path . -Name $fileName -ItemType File
    } else {
        Write-Host "File '$fileName' already exists"
    }
}

function mkdir ([string] $dirName) {
    if (!(Test-Path $dirName)) {
        Write-Host "Creating $dirName"
        New-Item -Path . -Name $dirName -ItemType Directory
    } else {
        Write-Host "Directory '$dirName' already exists"
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

# Push changes to github repository
function push([string] $arg) {
    if ($arg -eq "f") {
        Write-Host "Force pushing.."
        git push --force
    } else {
        Write-Host "Pushing.."
        git push
    }
}

# Stage all file changes to git
function add { git add --all }

# List all files in the specified directory
function ls { Get-Item * }

# Show the status of files in the current working directory
function st { git status }
