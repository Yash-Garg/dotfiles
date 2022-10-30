# shellcheck disable=SC1000-SC9999

eval "$(starship init zsh)"

export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export EDITOR=nano
export GPG_TTY=$(tty)
export UPDATE_ZSH_DAYS=7
export CLICOLOR=1
export PATH=$HOME/bin/:$HOME/Android/Sdk/platform-tools/:$PATH
export GRADLE_USER_HOME=$HOME/.gradle

alias ls="ls --color=auto"
alias push='git push'
alias fpush='git push --force'
alias amend='git commit --amend -S'
alias add='git add --all'
alias pull='git pull'
alias st='git status'
alias reset='git reset'
alias restore='git restore .'
alias commit='git commit --all -s -S -m'
alias log='git log --oneline --decorate --graph --all'

alias spbuild='flutter build apk --release --split-per-abi'
alias runner='flutter packages pub run build_runner build --delete-conflicting-outputs'
alias fget='flutter pub get'
alias run='flutter run'

alias cls='clear'
alias xc='xclip -sel clip'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
