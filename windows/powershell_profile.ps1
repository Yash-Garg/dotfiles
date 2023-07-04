Import-Module PSReadLine

Invoke-Expression (&starship init powershell)
Invoke-Expression (
    & {
        $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
        (zoxide init --hook $hook powershell | Out-String)
    }
)

Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Environment variables
$ENV:STARSHIP_CONFIG = "$HOME\starship.toml"
$ENV:FZF_DEFAULT_COMMAND = 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
$ENV:FZF_DEFAULT_OPTS = @"
--color=bg+:#313244,bg:-1,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
"@

# Aliases
Set-Alias -Name neofetch -Value winfetch -Option AllScope
Set-Alias -Name ls -Value lsd -Option AllScope
Set-Alias -Name a2 -Value aria2c -Option AllScope
Set-Alias -Name cd -Value z -Option AllScope
Set-Alias -Name cat -Value bat -Option AllScope
Set-Alias -Name firebase -Value firebase-win -Option AllScope
Set-Alias -Name e -Value explorer -Option AllScope

function gw {
    if (Test-Path ./gradlew) {
        ./gradlew @args
    }
    else {
        Write-Error "not a gradle project"
        return
    }
}

# To find where is the given command called from
function which ([string] $name) {
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
function commit ([string] $msg) {
    if (!$msg) {
        git commit -S
    }

    else {
        git commit -S -am $msg
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

# Open fzf and show the selected file in vscode
function v {
    $file = fzf --preview 'bat --color=always --style=numbers {}' @args
    if ($file) {
        code $file
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
function gdiff ([string] $sha) {
    if (!$sha) {
        $sha = "HEAD"
    }

    git diff $sha @args
}

function cmb ([int] $logSize) {
    if (!(Test-Path .git)) {
        Write-Error "not a git repository"
        return
    }

    if ($logSize -le 0) {
        $logSize = 20
    }

    $selectedCommit = $(
        git log -n $logSize --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" @args |
        fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort |
        ForEach-Object { $_ -match '^\*\s+([a-f0-9]+)' | Out-Null; $matches[1] }
    )

    if ($selectedCommit) {
        git show -w --color=always $selectedCommit
    }
}

function a {
    $totalLines = ((adb devices) | Measure-Object -Line).Lines
    $devicesConnected = $totalLines - 1

    if ($args -notlike "*-s *" -and $devicesConnected -gt 1) {
        $devices = ((adb devices) | Select-Object -Skip 1 | Select-Object -SkipLast 1).Split("`n") | ForEach-Object { $_.Split()[0] }

        $devicesText = ""

        foreach ($device in $devices) {
            $vendor = (adb -s $device shell getprop ro.product.manufacturer).Trim()
            $model = (adb -s $device shell getprop ro.product.model).Trim()

            $devicesText += "$device - $model ($vendor)`n"
        }

        $selection = $devicesText | fzf
        if (!$selection) {
            return
        }

        $deviceId = $selection.Split()[0]

        $Green = [ConsoleColor]::Green
        Write-Host "Device Selected: $selection" -ForegroundColor $Green

        adb -s $deviceId @args
    }
    else {
        adb @args
        return
    }
}

# List all files in the current working directory
function la { lsd -a }

function ll { lsd -l }

# Run flutter code generator
function runner { dart run build_runner build --delete-conflicting-outputs @args }

function fbuild { flutter build apk --release --split-per-abi @args }

# Compute file hashes - useful for checking successful downloads
function md5 { Get-FileHash -Algorithm MD5 @args }

function sha1 { Get-FileHash -Algorithm SHA1 @args }

function sha256 { Get-FileHash -Algorithm SHA256 @args }

function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) {
    Get-Process $name
}

Clear-Host
