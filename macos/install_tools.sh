if [[ $(command -v brew) == "" ]]; then
	echo "Installing Hombrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
else
	echo "Updating Homebrew"
	brew update
fi


brew install neovim \
    ripgrep \
    tmux \
    docker docker-compose

brew tap wez/wezterm
brew install --cask wez/wezterm/wezterm \
    google-chrome \
    bitwarden \
    spotify \
    discord \

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
