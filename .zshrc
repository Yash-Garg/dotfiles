# shellcheck disable=SC1000-SC9999

# Exports
# export STARSHIP_CONFIG=~/.starship/config.toml
export ZSH="/home/yash/.oh-my-zsh"
export PATH=~/Android/Sdk/platform-tools/:~/Android/flutter/bin:~/bin:$PATH
export LANG=en_US.UTF-8
export EDITOR=nano
export GPG_TTY=$(tty)
export UPDATE_ZSH_DAYS=7
export GRADLE_USER_HOME=~/.gradle

# Aliases

## Git
alias push='git push'
alias fpush='git push --force'
alias amend='git commit --amend -S'
alias add='git add --all'
alias pull='git pull'
alias st='git status'
alias reset='git reset'
alias restore='git restore *'
alias commit='git commit --all -s -S -m'
alias lg='git log --oneline --decorate --graph --all'

## Flutter
alias spbuild='fvm flutter build apk --release --split-per-abi'
alias runner='fvm flutter packages pub run build_runner build --delete-conflicting-outputs'
alias fget='fvm flutter pub get'
alias run='fvm flutter run'

## Misc
alias cls='clear'
alias tu='sudo tailscale up'
alias td='sudo tailscale down'
alias dev='scrcpy -m800 -b2M --always-on-top -w'
alias reload='source ~/.zshrc'
alias update='sudo apt-get -y update && sudo apt-get -y upgrade'

# Zsh
ZSH_THEME="honukai"
plugins=(
    git
    zsh-autosuggestions
    fast-syntax-highlighting
)
COMPLETION_WAITING_DOTS="true"

# Source
# eval "$(starship init zsh)"
source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env
source ~/functions.sh
