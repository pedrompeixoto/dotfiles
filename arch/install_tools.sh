sudo pacman -Syu neovim wezterm firefox git openssh spotify-launcher discord gcc xclip

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

git clone --depth 1 https://github.com/wbthomason/packer.nvim  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

git clone https://aur.archlinux.org/1password.git
cd 1password
makepkg -si
cd ..
rm -rf 1password
