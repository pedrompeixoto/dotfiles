if [[ $(command -v brew) == "" ]]; then
	echo "Installing Hombrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
else
	echo "Updating Homebrew"
	brew update
fi


brew install neovim
brew install ripgrep
brew install tmux
brew tap wez/wezterm
brew install --cask wez/wezterm/wezterm
brew install --cask google-chrome
brew install --cask bitwarden
brew install --cask spotify
brew install --cask discord

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
