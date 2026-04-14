#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

ok() { printf "%b[OK]%b %s\n" "$GREEN" "$NC" "$1"; }
fail() { printf "%b[ERR]%b %s\n" "$RED" "$NC" "$1"; }

# Install Homebrew if missing
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    fail "Homebrew install failed"
    exit 1
  }
  eval "$(/opt/homebrew/bin/brew shellenv)"
  ok "Homebrew installed"
else
  ok "Homebrew already installed"
fi

# Update
brew update

install() {
  if brew list "$1" >/dev/null 2>&1 || brew list --cask "$1" >/dev/null 2>&1; then
    ok "$1 already installed"
  else
    echo "Installing $1..."
    if brew install "$1" 2>/dev/null || brew install --cask "$1"; then
      ok "$1 installed"
    else
      fail "$1 failed"
    fi
  fi
}

# Packages
install brave-browser
install 1password
install mise
install neovim
install ghostty
install tree-sitter
install gh
install fd
install bitwarden

install tmux
# Install tmux plugin manager (tpm)
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
  echo "Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm" || fail "Failed to clone tpm"
  ok "tmux plugin manager installed"
else
  ok "tmux plugin manager already installed"
fi

# Install tmux plugins
if [ -d "$HOME/.config/tmux/plugins/tpm" ]; then
  echo "Installing tmux plugins..."
  "$HOME/.config/tmux/plugins/tpm/bin/install_plugins" || fail "Failed to install tmux plugins"
  ok "tmux plugins installed"
fi

# Add asdf to .zshrc PATH
if ! grep -q 'ASDF_DATA_DIR.*shims' "$HOME/.zshrc" 2>/dev/null; then
  echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> "$HOME/.zshrc"
  ok "asdf PATH added to .zshrc"
else
  ok "asdf PATH already in .zshrc"
fi

# Add asdf to current session PATH
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Install Node.js via mise
if mise which node >/dev/null 2>&1; then
  ok "Node.js already installed via mise"
else
  echo "Installing Node.js via mise..."
  if mise install node@lts; then
    mise use --global node@lts
    ok "Node.js installed via mise"
  else
    fail "Node.js install via mise failed"
  fi
fi

ok "Done"
