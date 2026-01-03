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
echo "Updating pacman and installing dependencies (git, python, ansible)..."
sudo pacman -Syu --noconfirm --needed git python python-pip ansible base-devel

# 3. Setup the repository
REPO_DIR="$HOME/.wsl-config"
if [[ ! -d "$REPO_DIR" ]]; then
    echo "Cloning configuration repository..."
    # Initial clone if not present. In a real scenario, the user would run the curl command.
    # For now, we assume the user might have cloned it or we clone it to a standard location.
    # If the script is being piped from curl, we clone to $HOME/.wsl-config
    git clone https://github.com/caelx/wsl-config.git "$REPO_DIR"
else
    echo "Repository already exists at $REPO_DIR. Pulling latest changes..."
    cd "$REPO_DIR" && git pull
fi

# 4. Run Ansible
echo "Running Ansible playbook..."
cd "$REPO_DIR/ansible"
ansible-playbook -i inventory.ini playbook.yml --ask-become-pass

echo "Bootstrap complete! Please restart your shell."
