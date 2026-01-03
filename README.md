# WSL2 Arch Linux Configuration

This repository contains scripts and Ansible playbooks to bootstrap and manage an Arch Linux environment on WSL2.

## Quick Start (Bootstrap)

To set up a fresh environment or update an existing one, run:

```bash
curl -sSL https://raw.githubusercontent.com/caelx/wsl-config/main/bootstrap.sh | bash
```

## Features

- **Pamac:** Uses `pamac-cli` as the primary package manager (with AUR support).
- **Fish Shell:** Sets `fish` as the default shell with a custom configuration.
- **Ansible:** Idempotent configuration management.
- **Dotfiles:** Managed via Ansible symlinks.

## Project Structure

- `bootstrap.sh`: The entry point script.
- `ansible/`: Playbooks and roles.
- `dotfiles/`: Configuration files for various tools.
