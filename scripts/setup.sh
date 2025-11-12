#!/bin/bash

# Author: nsweeting2
# This script is meant to be run after a fresh setup.

# This script assumes the following is true: You installed Arch Linux using archinstall.
# Archinstall settings expected: btrfs, a user with sudo permission, a minimal profile,
# networkmanager, and the git package installed.
# After archinstall and a reboot, login and run DankLinux setup
# curl -fsSL https://install.danklinux.com | sh
# DankLinux settings expected: Hyprland and Ghostty

# This is an interactive script!

# Trap for unexpected exits
trap 'trap_message' INT TERM

# Backup default dorfiles then create a symlink for my dotfiles
# Move file to be a .bak
mv ~/.bash_profile ~/.bash_profile.bak
mv ~/.config/DankMaterialShell/settings.json ~/.config/DankMaterialShell/settings.json.bak
mv ~/.config/ghostty/config ~/.config/ghostty/config.bak
mv ~/.config/hypr/binds_media.conf ~/.config/hypr/binds_media.conf.bak
mv ~/.config/hypr/binds.conf ~/.config/hypr/binds.conf.bak
mv ~/.config/hypr/dwindle.conf ~/.config/hypr/dwindle.conf.bak
mv ~/.config/hypr/env.conf ~/.config/hypr/env.conf.bak
mv ~/.config/hypr/monitors.conf ~/.config/hypr/monitors.conf.bak
mv ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.bak
# Symlink file from repo
ln -s ~/.dank-dots/bash_profile ~/.bash_profile
ln -s ~/.dank-dots/.config/DankMaterialShell/settings.json ~/.config/DankMaterialShell/settings.json
ln -s ~/.dank-dots/.config/ghostty/config ~/.config/ghostty/config
ln -s ~/.dank-dots/.config/hypr/binds_media.conf ~/.config/hypr/binds_media.conf
ln -s ~/.dank-dots/.config/hypr/binds.conf ~/.config/hypr/binds.conf
ln -s ~/.dank-dots/.config/hypr/dwindle.conf ~/.config/hypr/dwindle.conf
ln -s ~/.dank-dots/.config/hypr/env.conf ~/.config/hypr/env.conf
ln -s ~/.dank-dots/.config/hypr/monitors.conf ~/.config/hypr/monitors.conf
ln -s ~/.dank-dots/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf

# Copy over the all of the wallpapers
mkdir ~/Wallpapers
cp -rp ~/.dank-dots/Wallpapers/* ~/Wallpapers 

# List of AUR packages to install with YAY
packages=(
    "vivaldi"
    "chromium"
    "vscodium-bin"
    "nano"
    "btop"
    "ufw"
    "tufw"
    "fastfetch"
    "ttf-nerd-fonts-symbols"
    "ttf-nerd-fonts-symbols-mono"
    "ttf-fira-code"
    "ttf-fira-mono"
    "ttf-fira-sans"
    "ttf-firacode-nerd"
    "thunar"
    "tumbler"
    "yazi"
    "tar"
    "7zip"
    "pinta"
    "wev"
    "wget"
    "rsync"
    "qt6ct"
    "qt5ct"
    "nwg-look"
    "rsync"
    "vlc"
    "figlet"
    "fzf"
    "starship"
    "zoxide"
    "udiskie"
    "electron"
    "wisdom-tree"

)

# Install Yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd ..

# Install the packages using yay
yay -S --noconfirm "${packages[@]}"