source ~/functions.sh

export ZSH="/home/yash/.oh-my-zsh"

ZSH_THEME="honukai"

export UPDATE_ZSH_DAYS=7

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export EDITOR=nano

export PATH=~/Android/Sdk/platform-tools/:$PATH

export GPG_TTY=$(tty)

COMPLETION_WAITING_DOTS="true"
