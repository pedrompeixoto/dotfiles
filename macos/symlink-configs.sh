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

# Helper function to handle existing target (symlink or file/dir)
handle_existing_target() {
    local target_path=$1
    local is_dir=$2

    if [ ! -e "$target_path" ]; then
        return 0
    fi

    if [ -L "$target_path" ]; then
        rm "$target_path"
        printf "%b! Removed existing symlink: %s%b\n" "$YELLOW" "$target_path" "$NC"
        return 0
    fi

    printf "%b✗ %s%b\n" "$RED" "$target_path exists and is not a symlink" "$NC"
    read -p "  Do you want to remove it? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$target_path"
        printf "%b! Removed: %s%b\n" "$YELLOW" "$target_path" "$NC"
        return 0
    fi
    return 1
}

# Generic symlink creation function
create_symlink() {
    local source_path=$1
    local target_path=$2
    local display_name=$3
    local check_type=$4  # "file" or "dir"

    # Check if source exists
    if [ "$check_type" = "file" ] && [ ! -f "$source_path" ]; then
        printf "%b✗ Source not found: %s%b\n" "$RED" "$source_path" "$NC"
        return 1
    elif [ "$check_type" = "dir" ] && [ ! -d "$source_path" ]; then
        printf "%b✗ Source not found: %s%b\n" "$RED" "$source_path" "$NC"
        return 1
    fi

    # Handle existing target
    handle_existing_target "$target_path" || {
        printf "%b✗ Skipped symlinking %s%b\n" "$RED" "$display_name" "$NC"
        return 1
    }

    # Create symlink
    ln -s "$source_path" "$target_path"
    printf "%b✓ Symlinked %s%b\n" "$GREEN" "$display_name" "$NC"
    echo "  ${source_path} -> ${target_path}"
}

# Function to create symlink for directories
symlink_config() {
    local app_name=$1
    local source_path="${CONFIG_SOURCE}/${app_name}"
    local target_path="${HOME}/.config/${app_name}"

    # Create .config directory if it doesn't exist
    if [ ! -d "${HOME}/.config" ]; then
        mkdir -p "${HOME}/.config"
        printf "%b✓ Created %s%b\n" "$GREEN" "${HOME}/.config" "$NC"
    fi

    create_symlink "$source_path" "$target_path" "$app_name" "dir"
}

# Function to create symlink for individual files
symlink_file() {
    local source_file=$1
    local target_file=$2
    local display_name=$3

    create_symlink "$source_file" "$target_file" "$display_name" "file"
}

# Symlink nvim config
symlink_config "nvim"
symlink_config "ghostty"
symlink_config "tmux"

# Symlink git config
symlink_file "${CONFIG_SOURCE}/git/gitconfig" "${HOME}/.gitconfig" "gitconfig"

echo ""
printf "%b✓ Done!%b\n" "$GREEN" "$NC"
