#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
NC="\033[0m"

echo "Checking system..."

# Ensure macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    printf "%bError: This script only supports macOS.%b\n" "$RED" "$NC"
    exit 1
fi

# Ensure Apple Silicon (arm64)
ARCH=$(uname -m)
if [[ "$ARCH" != "arm64" ]]; then
    printf "%bError: This script only supports Apple Silicon Macs (arm64).%b\n" "$RED" "$NC"
    exit 1
fi

printf "%bApple Silicon macOS detected.%b\n" "$GREEN" "$NC"

# Check if Homebrew is installed
if command -v brew >/dev/null 2>&1; then
    printf "%bHomebrew is already installed.%b\n" "$GREEN" "$NC"
    exit 0
fi

printf "%bHomebrew not found. Installing...%b\n" "$YELLOW" "$NC"

# Install Homebrew (official script)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Verify installation
if [[ -x "/opt/homebrew/bin/brew" ]]; then
    printf "%bHomebrew installed successfully!%b\n" "$GREEN" "$NC"
else
    printf "%bError: Homebrew installation failed.%b\n" "$RED" "$NC"
    exit 1
fi

# Add Homebrew to PATH for current session
eval "$(/opt/homebrew/bin/brew shellenv)"

printf "%bSetup complete. Homebrew is ready to use.%b\n" "$GREEN" "$NC"
