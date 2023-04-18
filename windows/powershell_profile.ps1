Invoke-Expression (&starship init powershell)
Invoke-Expression (
    & {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
        (zoxide init --hook $hook powershell | Out-String)
    }
)

# Environment variables
$ENV:STARSHIP_CONFIG = "$HOME\starship.toml"
$ENV:FZF_DEFAULT_COMMAND = 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
$ENV:FZF_DEFAULT_OPTS = @"
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
"@

# Aliases
Set-Alias -Name neofetch -Value winfetch.ps1 -Option AllScope
Set-Alias -Name ls -Value lsd -Option AllScope
Set-Alias -Name a2 -Value aria2c -Option AllScope
Set-Alias -Name cd -Value z -Option AllScope

# To find where is the given command called from
function which($name) {
    Get-Command $name | Select-Object -ExpandProperty Definition
}

# Create a new empty file in the current working directory
function touch ([string] $file) {
    if (!(Test-Path $file)) {
        Write-Host "Creating $file"
        "" | Out-File $file -Encoding ASCII
    }
    else {
        Write-Host "File '$file' already exists"
    }
}

# Create a directory in the current working directory
function mkdir ([string] $dirName) {
    if (!(Test-Path $dirName)) {
        Write-Host "Creating $dirName"
        New-Item -Path . -Name $dirName -ItemType Directory
    }
    else {
        Write-Host "Directory '$dirName' already exists"
    }
}

# Create a signed commit with given message
function commit ([string] $commitMessage) {
    if ($commitMessage -ne "") {
        git commit -S -m $commitMessage
    }
    else {
        git commit -S @args
    }
}

# Show oneline log of commits of given size
function lg ([int] $logSize) {
    if ($logSize -le 0) {
        $logSize = 10
    }

    git log --oneline --decorate --graph --all -n $logSize

}

# Rebase given number of commits on current branch
function rebase ([int] $num) {
    if ($num -eq 0) {
        Write-Host "How many number of commits?"
    }
    else {
        git rebase -i HEAD~$num
    }
}

# Open fzf and show the selected file in bat
function v {
    $file = fzf @args
    if ($file) {
        bat $file
    }
}

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
function cmds { notepad (Get-PSReadLineOption | Select-Object -ExpandProperty HistorySavePath) }

# Cherry pick the given commit
function gcp { git cherry-pick @args }

# Delete all tags in the current repository
function dtags { git tag | ForEach-Object -process { git tag -d $_ } }

# Delete all local branches in the current repository
function dbranch { git for-each-ref --format '%(refname:short)' refs/heads | ForEach-Object { git branch $_ -D } }

# Diff between HEAD and current changes in the current repository
function gdiff { git diff HEAD @args | bat --pager=never }

# List all files in the current working directory
function la { ls -a }

# Run flutter code generator
function runner { flutter packages pub run build_runner build --delete-conflicting-outputs }

# Compute file hashes - useful for checking successful downloads
function md5 { Get-FileHash -Algorithm MD5 $args }

function sha1 { Get-FileHash -Algorithm SHA1 $args }

function sha256 { Get-FileHash -Algorithm SHA256 $args }

function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) {
    Get-Process $name
}

Clear-Host
