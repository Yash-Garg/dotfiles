# Set oh-my-posh theme to zash
# Set-PoshPrompt -Theme zash
Invoke-Expression (&starship init powershell)

# Create a new empty file in the current working directory
function touch ([string] $fileName) {
    if (!(Test-Path $fileName)) {
        Write-Host "Creating $fileName"
        New-Item -Path . -Name $fileName -ItemType File
    } else {
        Write-Host "File '$fileName' already exists"
    }
}

# Create a directory in the current working directory
function mkdir ([string] $dirName) {
    if (!(Test-Path $dirName)) {
        Write-Host "Creating $dirName"
        New-Item -Path . -Name $dirName -ItemType Directory
    } else {
        Write-Host "Directory '$dirName' already exists"
    }
}

# Create and move into the directory
function mkcd ([string] $dirName) {
    if (!(Test-Path $dirName)) {
        mkdir($dirName)
        Set-Location $dirName
    } else {
        Write-Host "Directory '$dirName' already exists! Moving into the directory."
        Set-Location $dirName
    }
}

# Clone the repository at the specified URL with specified branch
function clone ([string] $repo, [string] $branch) {
    if ($repo -ne "") {
        if ($branch -ne "") {
            git clone git@github.com:$repo -b $branch
        } else {
            git clone git@github.com:$repo
        }
    } else {
        Write-Host "You must specify a repository URL!"
    }
}

# Create a signed commit with given message
function commit ([string] $commitMessage) {
    if ($commitMessage -ne "") {
        git commit --all -S -m $commitMessage
    } else {
        Write-Host "Aborting! No commit message provided."
    }
}

# Show oneline log of commits of given size
function lg ([int] $logSize) {
    if ($logSize -le 0) {
        Write-Host "Using default log size of 10"
        git log --oneline -n 10
    } else {
        git log --oneline -n $logSize
    }
}

# Push changes to github repository
function push ([string] $arg) {
    if ($arg -eq "f") {
        Write-Host "Force pushing.."
        git push --force
    } else {
        Write-Host "Pushing.."
        git push
    }
}

# Rebase given number of commits on current branch
function rebase ([int] $num) {
    if ($num -eq 0) {
        Write-Host "Bruh! How many number of commits?"
    } else {
        git rebase -i HEAD~$num
    }
}

# Reload powershell profile
function reload {
    . $PROFILE
    & $PROFILE
}

# Flutter Stuff
function runner { flutter packages pub run build_runner build --delete-conflicting-outputs }

function spbuild { flutter build apk -t .\lib\main_debug.dart --release --split-per-abi }

function build { flutter build apk -t .\lib\main_debug.dart --release }

function run { flutter run -t .\lib\main_debug.dart --debug }

# Open scrcpy with the given options
function device { scrcpy --always-on-top -w -b2M -m800 }

# Modify the most recent commit
function amend { git commit --amend -S }

# Stage all file changes to git
function add { git add --all }

# Pull all changes from the remote repository
function pull { git pull }

# Show the status of files in the current working directory
function st { git status }
