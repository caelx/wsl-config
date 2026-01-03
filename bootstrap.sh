#!/bin/bash

# WSL2 Arch Linux Bootstrap Script
# This script prepares the environment and runs the Ansible playbook.

set -e

echo "Starting WSL2 Arch Linux Bootstrap..."

# 1. Check if we are running in WSL2
if [[ ! -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
    echo "WARNING: This script is intended for WSL2. Proceeding anyway..."
fi

# 2. Update pacman and install base dependencies
echo "Updating pacman and installing dependencies (git, python, pipx)..."
sudo pacman -Syu --noconfirm --needed git python python-pipx base-devel

# 3. Setup the repository
REPO_DIR="$HOME/.wsl-config"

# Detect if we are already running from inside the repo
if [[ -f "./ansible/playbook.yml" ]]; then
    echo "Running from existing local repository..."
    REPO_DIR=$(pwd)
else
    if [[ ! -d "$REPO_DIR" ]]; then
        echo "Cloning configuration repository..."
        git clone https://github.com/caelx/wsl-config.git "$REPO_DIR"
    else
        echo "Repository already exists at $REPO_DIR. Pulling latest changes..."
        cd "$REPO_DIR" && git pull
    fi
fi

# 4. Install Ansible via pipx
if ! pipx list --short | grep -q "^ansible "; then
    echo "Installing Ansible via pipx..."
    pipx install --include-deps ansible > /dev/null
fi

# 5. Run Ansible
echo "Running Ansible playbook..."
cd "$REPO_DIR/ansible"
pipx run --spec ansible ansible-playbook -i inventory.ini playbook.yml --ask-become-pass

echo "Bootstrap complete! Please restart your shell."
