#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Check if we're on tty1 and only then start Hyprland
if [[ $(tty) == /dev/tty1 ]]; then
  exec Hyprland
fi
