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

# List of AUR packages to install with YAY
packages=(
    "vivaldi"
    "package2"
    "package3"
    "package4"
    # Add more packages as needed
)

# Install Yay if it is not already installed.
if command -v yay > /dev/null; then
    print_info "Skipping yay installation (already installed)."
elif run_command "pacman -S --noconfirm --needed git base-devel" "Check: yay prereqs" "no" "yes"; then
    run_command "git clone https://aur.archlinux.org/yay.git && cd yay" "Clone: yay" "no" "no"
    run_command "makepkg --noconfirm -si && cd .." "Make: yay" "no" "no"
fi

# Install the packages using yay
yay -S --noconfirm "${packages[@]}"