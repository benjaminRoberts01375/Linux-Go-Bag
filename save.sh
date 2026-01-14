#!/bin/bash

# cd into the directory of this script
cd "$(dirname "$(readlink -f "$0")")"

rm -rf save
mkdir save
cd save

# Copy config files
cp -r /etc/xdg/waybar waybar
cp -r ~/.config/hypr hypr
cp -r ~/.config/rofi rofi
cp -r ~/.config/blender blender
cp -r ~/.supermaven .supermaven
cp -r ~/.config/warp-terminal warp-terminal
cp -r ~/.config/fastfetch fastfetch
cp -r ~/.config/pipewire pipewire
cp -r ~/.config/espanso espanso
cp /etc/pacman.conf pacman.conf

# Copy data
cp ~/Documents/wallpaper-left.jpg wallpaper-left.jpg
cp ~/Documents/wallpaper-right.jpg wallpaper-right.jpg
cp ~/.bash_history .bash_history
cp -r ~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/instances instances
cp -r ~/.var/app/com.hypixel.HytaleLauncher HytaleLauncher
cp -r ~/.local/share/fonts fonts
cp -r ~/.local/share/actions-for-nautilus actions-for-nautilus