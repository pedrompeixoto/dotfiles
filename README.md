# Dotfiles

Personal configuration files and setup scripts.

## Contents

- **configs/** — Configuration files for various tools
  - `nvim/` — Neovim configuration (init.lua + lua plugins)
  - `tmux/` — Tmux configuration
  - `git/` — Git configuration
  - `ghostty/` — Ghostty terminal configuration

- **macos/** — macOS setup and installation scripts
  - `install.sh` — Unified installer with interactive menu (recommended)
  - `install_homebrew.sh` — Homebrew installation
  - `install_tools.sh` — Development tools installation
  - `symlink-configs.sh` — Symlink configuration files to home directory
  - `config.sh` — System configuration script

## Quick Start

1. Clone the repository:
   ```bash
   git clone <repo-url> ~/dotfiles
   cd ~/dotfiles/macos
   ```

2. Run the unified installer:
   ```bash
   ./install.sh
   ```

   The installer provides an interactive menu to:
   - Install Homebrew
   - Install development tools (Node.js, Neovim, Tmux, etc.)
   - Symlink configuration files
   - Configure macOS settings and SSH/GitHub integration
   - Run all setup steps at once

### Individual Scripts

If you prefer to run individual setup scripts (from the `macos/` directory):
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
