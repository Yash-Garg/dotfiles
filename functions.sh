#!/usr/bin/env bash

function mkcd {
    if [ -z "${1}" ]; then
        echo "Invalid Input - Supply a folder name"
        return
    else
        mkdir -p "$1" && cd "$1" || exit
    fi
}

function ghclone {
    if [ -z "${1}" ]; then
        echo "Invalid Input - Supply a repository name dumb"
        return
    else
        git clone git@github.com:"$1"
    fi
}

function weather {
    if [ "$(tput cols)" -lt 125 ]; then # 125 is min size for correct display
        curl "wttr.in/~${1:-Ghaziabad}?0"
    else
        curl "wttr.in/~${1:-Ghaziabad}"
    fi
}

function device {
    if [ -z "${1}" ]; then
        echo "Invalid Input - Supply a device name and port"
        return
    else
        scrcpy -s "$1" --always-on-top -w
    fi
}

function lfconv {
	if [ -z "${1}" ]; then
        echo "Invalid path specified"
        return
    else
    	find "$1" -type f -print0 | xargs -0 dos2unix --
    fi
}

function wgetf {
    if [ -z "${1}" ]; then
        echo "Please input a valid URL!"
        return
    else
        wget -nd -r -np -R "index.html*" "$1"
    fi
}
