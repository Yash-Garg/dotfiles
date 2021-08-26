#!/usr/bin/env bash
#
# Copyright (C) Yash-Garg <yash.garg@outlook.in>
# Personal setup script for Ubuntu
#

# Clone dotfiles and cd into it
git clone https://github.com/Yash-Garg/dotfiles -b stable ~/dotfiles
cd ~/dotfiles || exit

# Setup custom packages key & repos
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | sudo apt-key add -
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | sudo tee /etc/apt/sources.list.d/tailscale.list

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
echo 'deb https://repo.windscribe.com/ubuntu bionic main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo rm -f packages.microsoft.gpg

sudo add-apt-repository ppa:tatokis/ckb-next -y

curl -s https://install.speedtest.net/app/cli/install.deb.sh | sudo bash

# Update & Upgrade the package list
sudo apt-get -y update
sudo apt-get -y upgrade

# Install packages
sudo apt install -y zsh git htop neofetch aria2 curl \
    zip unzip p7zip-full speedtest imwheel pavucontrol \
    pkg-config make cmake scrcpy xclip tailscale ckb-next \
    telegram-desktop clang code apt-transport-https windscribe-cli samba

# Setup Flutter
git clone https://github.com/flutter/flutter -b stable ~/Android/flutter

# Install Oh-My-ZSH & switch to zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /usr/bin/zsh

# Setup plugin and themes from in zsh directory
cp .oh-my-zsh/custom/themes/honukai.zsh-theme ~/.oh-my-zsh/custom/themes
git clone https://github.com/zsh-users/zsh-autosuggestions \
    "${ZSH_CUSTOM:$HOME/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
git clone https://github.com/zdharma/fast-syntax-highlighting \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/fast-syntax-highlighting

# Copy config files from dotfiles to root
cp {.imwheelrc,.zshrc,.nanorc,.gitconfig,functions.sh} ~/

# Reload zshrc
# shellcheck disable=SC1091
source "$HOME"/.zshrc
