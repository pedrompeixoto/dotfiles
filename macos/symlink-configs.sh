#!/bin/bash

# macOS symlink script for dotfiles configuration
# This script creates symlinks for configuration directories from the configs folder
# to their appropriate locations in the home directory

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_SOURCE="${SCRIPT_DIR}/../configs"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🔗 Symlinking dotfiles configurations..."
echo "Source: ${CONFIG_SOURCE}"
echo ""

# Function to create symlink
symlink_config() {
    local app_name=$1
    local source_path="${CONFIG_SOURCE}/${app_name}"
    local target_path="${HOME}/.config/${app_name}"

    # Check if source exists
    if [ ! -d "$source_path" ]; then
        echo -e "${RED}✗ Source not found: ${source_path}${NC}"
        return 1
    fi

    # Create .config directory if it doesn't exist
    if [ ! -d "${HOME}/.config" ]; then
        mkdir -p "${HOME}/.config"
        echo -e "${GREEN}✓ Created ${HOME}/.config${NC}"
    fi

    # Handle existing target
    if [ -e "$target_path" ]; then
        if [ -L "$target_path" ]; then
            # It's a symlink, remove it
            rm "$target_path"
            echo -e "${YELLOW}! Removed existing symlink: ${target_path}${NC}"
        else
            # It's a real directory/file
            echo -e "${RED}✗ ${target_path} exists and is not a symlink${NC}"
            read -p "  Do you want to remove it? (y/N) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm -rf "$target_path"
                echo -e "${YELLOW}! Removed: ${target_path}${NC}"
            else
                echo -e "${RED}✗ Skipped symlinking ${app_name}${NC}"
                return 1
            fi
        fi
    fi

    # Create symlink
    ln -s "$source_path" "$target_path"
    echo -e "${GREEN}✓ Symlinked ${app_name}${NC}"
    echo "  ${source_path} -> ${target_path}"
}

# Symlink nvim config
symlink_config "nvim"

echo ""
echo -e "${GREEN}✓ Done!${NC}"
