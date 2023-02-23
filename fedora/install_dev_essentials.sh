sudo dnf upgrade -y --refresh

sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub

sudo dnf install -y neovim \
	https://github.com/wez/wezterm/releases/download/20221119-145034-49b9839f/wezterm-20221119_145034_49b9839f-1.fedora36.x86_64.rpm \
	https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm \
	i3 i3status dmenu \
    ripgrep
