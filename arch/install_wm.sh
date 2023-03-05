sudo pacman -Syu xorg-server xorg-xinit awesome xterm nvidia pipewire pipewire-pulse pavucontrol iwd bluez bluez-utils

sudo systemctl enable --now systemd-resolved
sudo systemctl enable --now iwd
sudo systemctl enable --now bluetooth

