#!/bin/bash
set -e

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

error() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $1" >&2
  exit 1
}

log "Starting macOS configuration..."

# Disable press-and-hold
log "Disabling Apple press-and-hold feature..."
if defaults write -g ApplePressAndHoldEnabled -bool false; then
  log "✓ Press-and-hold disabled"
else
  error "Failed to disable press-and-hold"
fi

# Create SSH directory
SSH_DIR="$HOME/.ssh"
log "Setting up SSH directory: $SSH_DIR"
if [ -d "$SSH_DIR" ]; then
  log "SSH directory already exists"
else
  if mkdir -p "$SSH_DIR" && chmod 700 "$SSH_DIR"; then
    log "✓ SSH directory created with correct permissions"
  else
    error "Failed to create SSH directory"
  fi
fi

# Generate SSH key
SSH_KEY_PATH="$SSH_DIR/id_ed25519"
if [ -f "$SSH_KEY_PATH" ]; then
  log "SSH key already exists at $SSH_KEY_PATH"
  read -p "Overwrite existing key? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "Skipping SSH key generation"
  else
    log "Generating new SSH key..."
    ssh-keygen -t ed25519 -C "pmpeixoto@protonmail.com" -f "$SSH_KEY_PATH" -N "" -f "$SSH_KEY_PATH"
    log "✓ SSH key generated"
  fi
else
  log "Generating new SSH key..."
  if ssh-keygen -t ed25519 -C "pmpeixoto@protonmail.com" -f "$SSH_KEY_PATH" -N ""; then
    log "✓ SSH key generated at $SSH_KEY_PATH"
  else
    error "Failed to generate SSH key"
  fi
fi

# Verify SSH public key exists
if [ ! -f "${SSH_KEY_PATH}.pub" ]; then
  error "SSH public key not found at ${SSH_KEY_PATH}.pub"
fi

log "Reading SSH public key..."
sslpub="$(cat "${SSH_KEY_PATH}.pub")" || error "Failed to read SSH public key"
log "SSH public key loaded (${#sslpub} characters)"

# Get GitHub token
echo
log "Adding SSH key to GitHub..."
echo -n "GitHub personal access token (will not be echoed, press Enter to skip): "
read -s github_token
echo

if [ -z "$github_token" ]; then
  log "Skipping SSH key upload (no token provided)"
else
  # Add SSH key to GitHub
  log "Uploading SSH key to GitHub API..."
  response=$(curl -s -w "\n%{http_code}" \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${github_token}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/user/keys \
    -d "{\"title\":\"skyvalley key\",\"key\":\"${sslpub}\"}")

  http_code=$(echo "$response" | tail -1)
  body=$(echo "$response" | sed '$d')

  if [ "$http_code" = "201" ]; then
    log "✓ SSH key successfully added to GitHub"
  elif [ "$http_code" = "422" ]; then
    log "SSH key already exists on GitHub (skipping)"
  else
    error "Failed to add SSH key to GitHub (HTTP $http_code): $body"
  fi
fi

log "macOS configuration complete!"
