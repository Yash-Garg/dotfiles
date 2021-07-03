#!/usr/bin/env bash

function mkcd {
    if [ -z ${1} ]; then
        echo "Invalid Input - Supply a folder name"
        return
    else
        mkdir -p $1 && cd $1
    fi
}

function ghclone {
    if [ -z ${1} ]; then
        echo "Invalid Input - Supply a repository name dumb"
        return
    else
        git clone git@github.com:$1
    fi
}

function reload {
    source ~/.zshrc
}

function weather {
    if [ "$(tput cols)" -lt 125 ]; then # 125 is min size for correct display
        curl "wttr.in/~${1:-Ghaziabad}?0"
    else
        curl "wttr.in/~${1:-Ghaziabad}"
    fi
}
