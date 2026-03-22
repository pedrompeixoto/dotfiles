# Dotfiles

Personal configuration files and setup scripts.

## Contents

- **configs/** — Configuration files for various tools
  - `nvim/` — Neovim configuration (init.lua + lua plugins)
  - `tmux/` — Tmux configuration
  - `git/` — Git configuration
  - `ghostty/` — Ghostty terminal configuration

- **macos/** — macOS setup and installation scripts
  - `config.sh` — System configuration script
  - `install_homebrew.sh` — Homebrew installation
  - `install_tools.sh` — Development tools installation
  - `symlink-configs.sh` — Symlink configuration files to home directory

## Quick Start

1. Clone the repository:
   ```bash
   git clone <repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. Run setup scripts (from the `macos/` directory):
   ```bash
   ./install_homebrew.sh   # Install Homebrew
   ./install_tools.sh      # Install development tools
   ./symlink-configs.sh    # Link config files to home
   ./config.sh             # Configure macOS settings
   ```

## Tools Configured

- **Neovim** — Text editor with LSP support
- **Tmux** — Terminal multiplexer
- **Git** — Version control
- **Ghostty** — Terminal emulator
