Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\starship.toml"

# Aliases
Set-Alias neofetch winfetch.ps1
Set-Alias ls lsd
Set-Alias a2 aria2c

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
        git commit -S -m $commitMessage
    } else {
        git commit -S @args
    }
}

# Show oneline log of commits of given size
function lg ([int] $logSize) {
    if ($logSize -le 0) {
        Write-Host "Using default log size of 10"
        git log --oneline --decorate --graph --all -n 10
    } else {
        git log --oneline --decorate --graph --all -n $logSize
    }
}

# Rebase given number of commits on current branch
function rebase ([int] $num) {
    if ($num -eq 0) {
        Write-Host "How many number of commits?"
    } else {
        git rebase -i HEAD~$num
    }
}

# Download a folder with wget incl. parameters
function dlf ([string] $url) {
    if ($url -eq "") {
        Write-Host "Please input a valid URL!"
    } else {
        Write-Host $url
        wget -nd -r -np -R "index.html*" $url
    }
}

# Flutter Stuff
function runner { flutter packages pub run build_runner build --delete-conflicting-outputs }
function build { flutter build apk --release @args }
function run { flutter run @args }

# Open scrcpy with the given options
function device { scrcpy --always-on-top -w -b2M -m800 @args }

# Modify the most recent commit
function amend { git commit --amend -S @args }

# Restore all files back from git history
function rst { git reset; git restore * }

# Stage all file changes to git
function add { git add --all @args }

# Pull all changes from the remote repository
function pull { git pull @args }

# Push changes to remote repository
function push { git push @args }

# Force push changes to remote repository
function fpush { git push --force @args }

# Show the status of files in the current working directory
function st { git status @args }

# Open commands history log in notepad
function cmds { notepad (Get-PSReadLineOption | select -ExpandProperty HistorySavePath) }

function cherry { git cherry-pick @args }

function gdiff { git diff HEAD @args | bat --pager=never }

cls
