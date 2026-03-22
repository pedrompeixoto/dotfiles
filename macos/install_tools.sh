#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

ok() { echo "${GREEN}[OK]${NC} $1"; }
fail() { echo "${RED}[ERR]${NC} $1"; }

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
install 1password
install asdf
install neovim
install ghostty
install brave-browser

# Add asdf to .zshrc PATH
if ! grep -q 'ASDF_DATA_DIR.*shims' "$HOME/.zshrc" 2>/dev/null; then
  echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> "$HOME/.zshrc"
  ok "asdf PATH added to .zshrc"
else
  ok "asdf PATH already in .zshrc"
fi

# Add asdf to current session PATH
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Install Node.js via asdf
if command -v asdf >/dev/null 2>&1; then
  if ! asdf plugin list | grep -q "^nodejs"; then
    echo "Adding asdf nodejs plugin..."
    asdf plugin add nodejs || fail "Failed to add nodejs plugin"
  fi
  echo "Installing Node.js with asdf..."
  asdf install nodejs latest || fail "Failed to install nodejs"
  asdf set --home nodejs latest || fail "Failed to set global nodejs version"
  ok "Node.js installed via asdf"

  # Install pnpm
  echo "Installing pnpm..."
  npm install -g pnpm || fail "Failed to install pnpm"
  ok "pnpm installed"
else
  fail "asdf not found, skipping Node.js installation"
fi

ok "Done"
