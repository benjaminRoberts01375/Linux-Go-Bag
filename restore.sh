#!/bin/bash

# cd into the directory of this script
cd "$(dirname "$(readlink -f "$0")")"
cd save

# Setup Pacman
sudo cp pacman.conf /etc/pacman.conf

# Initial updates
sudo pacman -Syu --noconfirm

# Install initial packages
sudo pacman -S --noconfirm --needed waybar rofi-wayland firefox ripgrep-all git base-devel flatpak nautilus blender curl hyprpolkitagent cifs-utils smbclient gvfs gvfs-smb font-manager gdm discord python-psutil hyprpaper steam go fastfetch libreoffice-still

# Install Yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Update Yay
yay -Syu --noconfirm

# Install Yay packages
yay -S --needed --noconfirm visual-studio-code-bin espanso-wayland actions-for-nautilus-git

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

# Install Warp
sudo sh -c "echo -e '\n[warpdotdev]\nServer = https://releases.warp.dev/linux/pacman/\$repo/\$arch' >> /etc/pacman.conf"
sudo pacman-key -r "linux-maintainers@warp.dev"
sudo pacman-key --lsign-key "linux-maintainers@warp.dev"
sudo pacman -Sy warp-terminal
curl -L -o warp.pkg.tar.zst https://app.warp.dev/download?package=pacman
sudo pacman -U ./warp.pkg.tar.zst

# Install Docker
wget https://download.docker.com/linux/static/stable/x86_64/docker-28.2.1.tgz -qO- | tar xvfz - docker/docker --strip-components=1
sudo mv ./docker /usr/local/bin

# Install Golang's Air
go install github.com/air-verse/air@latest

# Install Bun
curl -fsSL https://bun.sh/install | bash

# Make font directory
mkdir -p ~/.local/share/fonts
yay -S ttf-firacode-nerd

# Setup PrismLauncher
(flatpak run org.prismlauncher.PrismLauncher & sleep 2 && flatpak kill org.prismlauncher.PrismLauncher && cp -r instances ~/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/) </dev/null &>/dev/null & # Ensures the app has files setup

# Move files
mkdir ~/Documents
cp -r warp-terminal ~/.config/
cp -r blender ~/.config/
cp -r rofi ~/.config/
cp -r .supermaven ~/
cp -r fonts ~/.local/share/
cp -r fastfetch ~/.config/
cp -r pipewire ~/.config/
cp -r espanso ~/.config/
cp -r actions-for-nautilus ~/.local/share/actions-for-nautilus
cp wallpaper-left.jpg ~/Documents/wallpaper-left.jpg
cp wallpaper-right.jpg ~/Documents/wallpaper-right.jpg
cp .bash_history ~/.bash_history
sudo cp -r waybar /etc/xdg/
cp -r hypr ~/.config/

# Remove default apps
sudo pacman -Rnsu dolphin 2>/dev/null || true
sudo pacman -Rnsu kitty 2>/dev/null || true

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
sudo chmod +x /etc/xdg/waybar/network.py
sudo chmod +x /etc/xdg/waybar/volume.py

# Set EQ
pactl set-default-sink effect_input.eq10

echo "Restore complete!"
echo "Restarting out in 3 seconds..."
sleep 3
sudo reboot
