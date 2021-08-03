source ~/functions.sh

ZSH_THEME="honukai"
plugins=(git)
source $ZSH/oh-my-zsh.sh
COMPLETION_WAITING_DOTS="true"

export ZSH="/home/yash/.oh-my-zsh"
export CHROME_EXECUTABLE="/opt/google/chrome/google-chrome"
export LANG=en_US.UTF-8
export EDITOR=nano
export PATH=~/Android/Sdk/platform-tools/:~/binaries:$PATH
export GPG_TTY=$(tty)
export UPDATE_ZSH_DAYS=7
