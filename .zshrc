# Exports
export ZSH="/home/yash/.oh-my-zsh"
# export STARSHIP_CONFIG=~/.starship/config.toml
export PATH=~/Android/Sdk/platform-tools/:~/Android/flutter/bin:$PATH
export LANG=en_US.UTF-8
export EDITOR=nano
export GPG_TTY=$(tty)
export UPDATE_ZSH_DAYS=7
export GRADLE_USER_HOME=~/.gradle

# Aliases
alias push='git push'
alias fpush='git push --force'
alias reload='source ~/.zshrc'
alias amend='git commit --amend -S'
alias add='git add --all'
alias pull='git pull'
alias st='git status'
alias commit='git commit --all -s -S -am'
alias cls='clear'
alias tu='sudo tailscale up'
alias td='sudo tailscale down'
alias dev='scrcpy -m800 -b2M --always-on-top -w'
alias reset='git reset'

# Misc.
ZSH_THEME="honukai"
plugins=(
    git
    zsh-autosuggestions
)
COMPLETION_WAITING_DOTS="true"

# Source
# eval "$(starship init zsh)"
source $ZSH/oh-my-zsh.sh
source ~/functions.sh

