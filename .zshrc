source ~/functions.sh

export ZSH="/home/yash/.oh-my-zsh"
export PATH=~/Android/Sdk/platform-tools/:/home/linuxbrew/.linuxbrew/bin:$PATH
export LANG=en_US.UTF-8
export EDITOR=nano
export GPG_TTY=$(tty)
export UPDATE_ZSH_DAYS=7
export GRADLE_USER_HOME=~/.gradle

ZSH_THEME="honukai"
plugins=(git)
COMPLETION_WAITING_DOTS="true"
source $ZSH/oh-my-zsh.sh
