#
# ~/.dank-dots/scripts/setup.sh
#

# !/bin/bash

# Author: nsweeting2
# This script is meant to be run on a fresh setup
# Using this otherwise will likely jack shit up

# This script assumes the following is true: You installed Arch Linux using archinstall.
# Archinstall settings expected: btrfs, LVM, a user with sudo permission, a minimal profile,
# networkmanager, and the git package installed.
# After archinstall and a reboot, login and run DankLinux setup
# curl -fsSL https://install.danklinux.com | sh
# DankLinux settings expected: Hyprland and Ghostty

# This is an semi-interactive script, you will need a sudo password for yay
# I want to defeate this in the future but it is a long way out for now

##### [ Configuration Check List ] ######################## [ Status ]
# Clone yay Repo to yay                                       [ Done ]
# Run makepkg form yay repo                                   [ Done ]
# Define all packages to be installed via yay
# Install all yay packages                                             [ Done ]
# Backup and symlink DankMaterialShell/settings.json                   [ Done ]
# Backup and symlink Hypr/hyprland.conf                                [ Done ]
# Backup and symlink ghostty/config                                    [ Done ]
# Backup and symlink btop/btop.conf                                    [ Done ]
# Add btop to app launcher
# Copy over btop/themes folder                                         [ Done ]
# Symlink fastfetch/config.jsonc (No default)                          [ File is out of date ]
# Add fastfetch to app launcher
# Symlink .nanorc config (No default)                              [ Done ]
# Symlink starship.toml (No default)                               [ Done ]
# Symlink yazi/theme.toml and others
# Add yazi to app launcher
# Turn on UFW and add default rules
# Add TUFW to App launcher
# symlink udiskie/config.yml (no default)



# chromium
# vivaldi
# yazi
# zoxide
# ?. Copy over Wallpapers folder
# Copy over bashrc and bashprofile

# Exit the script if anything fails
set -e

# File backup function, moves file to be an in place .bak
function backup {
    if [ -f $1 ]; then mv $1 "${1}.bak"; fi
}

# File symlink function, symlinks file to .dank-files
function symlink {
    if [ ! -f $1 ]; then ln -s $1 $2
}

# Clone yay Repo
git clone https://aur.archlinux.org/yay.git

# Run makepkg form yay repo
cd yay && makepkg --noconfirm -si ; cd ..

# Define all packages to be installed via yay
packages=(
    "7zip"                        # A file archiver with a high compression ratio that supports many formats (7z, XZ, ZIP, RAR, etc.).
    "btop"                        # A modern, interactive, and customizable resource monitor (like htop) that shows CPU, memory, and process usage in the terminal.
    "chromium"                    # An open-source web browser project developed by Google that forms the basis for Google Chrome and Vivaldi.
    "fastfetch"                   # A high-speed and highly customizable system information fetching tool for the terminal (similar to Neofetch).
    "figlet"                      # A command-line program that creates large, stylized ASCII text banners out of ordinary text.
    "fzf"                         # A general-purpose command-line fuzzy finder, used to interactively search and filter lists (files, history, etc.).
    "nano"                        # A simple, easy-to-use, and lightweight text editor for the command-line interface.
    "nwg-look"                    # A GTK-based utility for configuring GTK themes, icons, fonts, and cursors, particularly useful in Wayland environments.
    "pinta"                       # A free, open-source program for drawing and basic image editing (similar to Paint.NET), supporting layers and effects.
    "qt5ct"                       # A utility to configure Qt5 settings (style, fonts, icons) under non-KDE desktop environments.
    "qt6ct"                       # A utility to configure Qt6 settings (style, fonts, icons) under non-KDE desktop environments.
    "rsync"                       # A utility for efficiently transferring and synchronizing files to and from remote computers or local directories.
    "starship-git"                # A minimal, fast, and customizable prompt for any shell, providing context-aware information (e.g., Git status, language versions).
    "tar"                         # The standard utility for creating and manipulating "tape archive" files, commonly used to bundle files into a single archive (a "tarball").
    "ttf-fira-code"               # The Fira Code font family, which includes programming ligatures (combining characters like `->` into a single symbol).
    "ttf-fira-mono"               # The monospaced variant of the Fira font family, designed for code and command-line interfaces.
    "ttf-fira-sans"               # The humanist sans-serif variant of the Fira font family, designed for general text and web use.
    "ttf-firacode-nerd"           # The Nerd Fonts patched version of Fira Code, adding thousands of icons (Glyphs) for powerline and development use.
    "ttf-nerd-fonts-symbols"      # A package providing thousands of symbols/icons merged into popular programming fonts for terminal use.
    "ttf-nerd-fonts-symbols-mono" # The monospaced symbol fonts, ensuring consistent spacing in the terminal.
    "tufw"                        # A Terminal User Interface (TUI) for **ufw** (Uncomplicated Firewall), providing an interactive way to manage firewall rules.
    "udiskie"                     # A **UDisks** front-end that automatically mounts and unmounts removable media (like USB drives) with optional notifications and a tray icon.
    "ufw"                         # The **Uncomplicated Firewall**, a program for managing the Netfilter firewall, designed to be easy to use.
    "vlc"                         # A free and open-source, cross-platform media player and streaming media server that plays most multimedia files.
    "vivaldi"                     # A freeware web browser developed by Vivaldi Technologies, known for its high level of customization and feature set.
    "vscodium-bin"                # The pre-compiled binary version of VSCodium, a community-driven, telemetry-free distribution of VS Code.
    "wev"                         # A debugging utility for Wayland that creates a window and prints all the Wayland events it receives (analogous to X11's `xev`).
    "wget"                        # A free utility for non-interactive downloading of files from the web, supporting HTTP, HTTPS, and FTP protocols.
    "wisdom-tree"                 # (Uncommon) Likely an AUR package for a specific terminal utility or a component related to a larger configuration; the name suggests a directory/file tree view or analysis tool.
    "yazi"                        # A modern, blazing-fast terminal file manager written in Rust, featuring asynchronous I/O and image previews.
    "zoxide"                      # A smart `cd` command written in Rust that learns your most used directories and allows you to jump to them quickly.
)


# Install all defined YAY packages
yay -S --noconfirm "${packages[@]}"

# Backup DankMaterialShell settings.json, then symlink from .dank-dots
default_file = "~/.config/DankMaterialShell/settings.json"
dank_file = "~/.dank-dots/.config/DankMaterialShell/settings.json"
backup $default_file
symlink $default_file $dank_file

# Backup Hypr .conf files, then symlink from .dank-dots
default_file = "~/.config/hypr/hyprland.conf"
dank_file = "~/.dank-dots/.config/hypr/hyprland.conf"
backup $default_file
symlink $default_file $dank_file

# Backup ghostty config, then symlink from .dank-dots
default_file = "~/.config/ghostty/config"
dank_file = "~/.dank-dots/.config/ghostty/config"
backup $default_file
symlink $default_file $dank_file

# Backup btop config, then symlink from .dank-dots
default_file = "~/.config/btop/btop.conf"
dank_file = "~/.dank-dots/.config/btop/btop.conf"
backup $default_file
symlink $default_file $dank_file

# Add btop to app launcher

# Copy over btop/themes folder from .dank-dots
mkdir -p ~/.config/btop/themes
cp -rp ~/.dank-dots/btop/themes/* ~/.config/btop/themes

# Symlink fastfetch config from .dank-dots (No default config)
default_file = "~/.config/fastfetch/config.jsonc"
dank_file = "~/.dank-dots/.config/fastfetch/config.jsonc"
# backup $default_file
symlink $default_file $dank_file

# Add fastfetch to app launcher

# Symlink nano config from .dank-dots (No default config)
default_file = "~/.nanorc"
dank_file = "~/.dank-dots/.nanorc"
# backup $default_file
symlink $default_file $dank_file

# Symlink starship.toml (No default)
default_file = "~/.config/starship.toml"
dank_file = "~/.dank-dots/.config/starship.toml"
# backup $default_file
symlink $default_file $dank_file

# Symlink yazi/theme.toml and others

# Add yazi to app launcher

# Turn on UFW and add default rules

# Add TUFW to App launcher

# symlink udiskie/config.yml (no default)
default_file = "~/.config/udiskie/config.yml"
dank_file = "~/.dank-dots/.config/udiskie/config.yml"
# backup $default_file
symlink $default_file $dank_file




# Copy over Wallpapers folder from .dank-dots
mkdir -p ~/Wallpapers
cp -rp ~/.dank-dots/Wallpapers/* ~/Wallpapers 

































# ? Backup .bash_profile, then symlink from .dank-dots
# Move file to be a .bak
mv ~/.bash_profile ~/.bash_profile.bak
# Symlink file from repo
ln -s ~/.dank-dots/bash_profile ~/.bash_profile



# ?. Make Wallpapers folder in Home, then copy Wallpaper folder from .dank-dots 
# Make the Wallpapers folder
mkdir ~/Wallpapers
# Copy over all of the files
cp -rp ~/.dank-dots/Wallpapers/* ~/Wallpapers 











