
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
brew install tmux
brew tap wez/wezterm
brew install --cask wez/wezterm/wezterm
brew install --cask google-chrome

