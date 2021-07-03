#!/usr/bin/env bash

function mkcd {
    mkdir -p $1 && cd $1
}

function ghclone {
    git clone git@github.com:$1
}
