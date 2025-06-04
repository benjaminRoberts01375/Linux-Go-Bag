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
cp /etc/pacman.conf pacman.conf

# Copy data
cp ~/Documents/wallpaper.jpg wallpaper.jpg
cp ~/.bash_history .bash_history
cp -r ~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/instances instances
cp -r ~/.local/share/fonts fonts