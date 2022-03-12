eval "$(starship init zsh)"

export PATH="$PATH:$HOME/flutter/bin:$HOME/flutter/bin/cache/dart-sdk/bin:$HOME/.pub-cache/bin:$HOME/bin:$HOME/Library/Android/sdk/platform-tools:/opt/homebrew/opt/openjdk@11/bin"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export STARSHIP_CONFIG=$HOME/.starship/config.toml
export GPG_TTY=$(tty)

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
alias spbuild='flutter build apk --release --split-per-abi'
alias runner='flutter packages pub run build_runner build --delete-conflicting-outputs'
alias fget='flutter pub get'
alias run='flutter run'
alias cls='clear'

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
