#!/bin/bash

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
NC="\033[0m"

echo "Checking system..."

# Ensure macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "${RED}Error: This script only supports macOS.${NC}"
    exit 1
fi

# Ensure Apple Silicon (arm64)
ARCH=$(uname -m)
if [[ "$ARCH" != "arm64" ]]; then
    echo "${RED}Error: This script only supports Apple Silicon Macs (arm64).${NC}"
    exit 1
fi

echo "${GREEN}Apple Silicon macOS detected.${NC}"

# Check if Homebrew is installed
if command -v brew >/dev/null 2>&1; then
    echo "${GREEN}Homebrew is already installed.${NC}"
    exit 0
fi

echo "${YELLOW}Homebrew not found. Installing...${NC}"

# Install Homebrew (official script)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Verify installation
if [[ -x "/opt/homebrew/bin/brew" ]]; then
    echo "${GREEN}Homebrew installed successfully!${NC}"
else
    echo "${RED}Error: Homebrew installation failed.${NC}"
    exit 1
fi

# Add Homebrew to PATH for current session
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "${GREEN}Setup complete. Homebrew is ready to use.${NC}"
