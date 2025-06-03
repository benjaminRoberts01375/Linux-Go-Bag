#!/bin/bash

# cd into the directory of this script
cd "$(dirname "$(readlink -f "$0")")"
cd save

# Initial updates
sudo pacman -Syu --noconfirm

# Install initial packages
sudo pacman -S --noconfirm --needed waybar rofi-wayland firefox ripgrep-all git base-devel flatpak nautilus blender curl hyprpolkitagent cifs-utils smbclient gvfs gvfs-smb font-manager gdm discord

# Install Yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Update Yay
yay -Syu --noconfirm

# Install Yay packages
yay -S --needed --noconfirm visual-studio-code-bin

# Install Flatpak
flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y flathub org.prismlauncher.PrismLauncher
flatpak install -y flathub io.github.shiftey.Desktop

# Install 1Password
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import
git clone https://aur.archlinux.org/1password.git
cd 1password
makepkg -si
cd ..
rm -rf 1password

# Make font directory
mkdir -p ~/.local/share/fonts

# Move files
cp -r hypr ~/.config/hypr
cp -r warp-terminal ~/.config/warp-terminal
cp -r blender ~/.blender
cp -r .supermaven ~/.supermaven
cp -r org.prismlauncher.PrismLauncher ~/.var/app/org.prismlauncher.PrismLauncher
cp -r fonts ~/.local/share/fonts 
cp wallpaper ~/Documents/wallpaper.jpg
cp .bash_history ~/.bash_history
sudo cp -r waybar /etc/xdg/waybar

# Remove default apps
sudo pacman -Rnsu dolphin 2>/dev/null || true

# Default settings
sudo systemctl disable sddm
sudo systemctl enable gdm
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# Remove unneeded packages
sudo pacman -Rsn $(pacman -Qdtq)

# Setup permissions
sudo chmod +x /etc/xdg/waybar/cpu_vbar.py
sudo chmod +x /etc/xdg/waybar/mem_vbar.py
sudo chmod +x /etc/xdg/waybar/mic.py
sudo chmod +x /etc/xdg/waybar/networking.py
sudo chmod +x /etc/xdg/waybar/volume.py

sudo reboot