#!/usr/bin/fish

# Path configuration
fish_add_path --move "$HOME/.local/bin"
fish_add_path --move "$HOME/.gemini/bin"

# PAC (Pamac CLI Wrapper) configuration
set -gx PAC_USE_AUR 1
set -gx PAC_MUTE_CMD_ECHO 1

# Editor
set -gx EDITOR (type -p nvim)
set -gx VISUAL "$EDITOR"
