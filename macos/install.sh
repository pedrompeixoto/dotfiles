#!/bin/bash

# macOS Unified Installer for Dotfiles
# This script provides an interactive menu to run setup scripts

set -e

GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
NC="\033[0m"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

log() { printf "%b[✓]%b %s\n" "$GREEN" "$NC" "$1"; }
error() { printf "%b[✗]%b %s\n" "$RED" "$NC" "$1" >&2; exit 1; }
info() { printf "%b[i]%b %s\n" "$BLUE" "$NC" "$1"; }

# Ensure macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    error "This script only supports macOS"
fi

# Ensure Apple Silicon
if [[ "$(uname -m)" != "arm64" ]]; then
    error "This script only supports Apple Silicon Macs (arm64)"
fi

show_menu() {
    echo ""
    printf "%b=== macOS Dotfiles Setup ===%b\n" "$BLUE" "$NC"
    echo ""
    echo "1) Install Homebrew"
    echo "2) Install Development Tools (Node.js, Neovim, Tmux, etc.)"
    echo "3) Symlink Configuration Files"
    echo "4) Configure macOS Settings & SSH/GitHub"
    echo "5) Run All Setup Steps"
    echo "6) Exit"
    echo ""
    printf "%bSelect options (e.g., 1,2,3 or 1 2 3 for multiple):%b\n" "$YELLOW" "$NC"
    printf "Enter your selection: "
}

run_script() {
    local script=$1
    local name=$2

    if [ ! -f "$SCRIPT_DIR/$script" ]; then
        error "Script not found: $SCRIPT_DIR/$script"
    fi

    echo ""
    info "Running: $name"
    bash "$SCRIPT_DIR/$script" || error "Failed to run $name"
    log "$name completed"
}

parse_selections() {
    local input=$1
    local selections=()

    # Replace commas with spaces and handle both comma and space separated input
    input="${input//,/ }"

    # Split by spaces and validate each number
    for num in $input; do
        # Check if it's a valid number between 1-6
        if [[ $num =~ ^[1-6]$ ]]; then
            selections+=("$num")
        else
            error "Invalid option: $num. Please select from 1-6"
        fi
    done

    # Remove duplicates and sort
    local sorted=$(printf '%s\n' "${selections[@]}" | sort -u | tr '\n' ' ')
    echo "$sorted"
}

run_selections() {
    local selections=$1
    local to_run=()

    # Check if running all (option 5)
    if echo "$selections" | grep -q "5"; then
        selections="1 2 3 4"
    fi

    # Build array of scripts to run in order
    for option in $selections; do
        case $option in
            1) to_run+=("install_homebrew.sh:Homebrew Installation") ;;
            2) to_run+=("install_tools.sh:Development Tools Installation") ;;
            3) to_run+=("symlink-configs.sh:Configuration Symlinks") ;;
            4) to_run+=("config.sh:macOS Configuration & SSH/GitHub Setup") ;;
        esac
    done

    if [ ${#to_run[@]} -eq 0 ]; then
        error "No valid options selected"
    fi

    echo ""
    info "Setup plan:"
    for i in "${!to_run[@]}"; do
        local script_info="${to_run[$i]}"
        local name="${script_info##*:}"
        echo "  $((i+1)). $name"
    done
    echo ""

    read -p "Continue with setup? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "Setup cancelled"
        return
    fi

    # Run scripts in order
    for script_info in "${to_run[@]}"; do
        local script="${script_info%%:*}"
        local name="${script_info##*:}"
        run_script "$script" "$name"
    done

    echo ""
    printf "%b========================================%b\n" "$GREEN" "$NC"
    printf "%bSelected setup steps completed!%b\n" "$GREEN" "$NC"
    printf "%b========================================%b\n" "$GREEN" "$NC"
}

# Main menu loop
while true; do
    show_menu
    read -r choice

    # Exit option
    if [[ "$choice" == "6" ]]; then
        info "Exiting installer"
        exit 0
    fi

    # Skip empty input
    if [[ -z "$choice" ]]; then
        error "Please enter at least one option"
    fi

    # Parse and validate selections
    selections=$(parse_selections "$choice")

    # Check if only exit option was selected
    if echo "$choice" | grep -qE "[1-5]"; then
        run_selections "$selections"
    else
        error "Invalid option. Please select from 1-6"
    fi

    echo ""
    read -p "Press Enter to continue..."
done
