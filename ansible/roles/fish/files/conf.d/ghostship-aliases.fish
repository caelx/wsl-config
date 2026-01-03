#!/usr/bin/fish

# Core Aliases
alias c="/usr/bin/cat"
alias cat="bat --style plain --paging never"
alias dig="drill"
alias fd="fd --follow"
alias gi="gitignore"
alias l="/usr/bin/ls --color -h --group-directories-first -p"
alias ld="fd --type directory --max-depth 1"
alias lda="fd --type directory"
alias lf="fd --type file --max-depth 1"
alias lfa="fd --type file"
alias ll="lsd -lha"
alias loadenv="replay"
alias ls="lsd"
alias lsd="lsd --group-directories-first --icon never --human-readable"
alias rg="rga"
alias tree="lsd --tree"
alias reload="clear;exec fish"
alias vissh="vi $HOME/.ssh/config"

# Zoxide initialization
if type -q zoxide
    zoxide init fish | source
    alias j="z"
end

# Functions
function rmssh --description "Cleanup SSH multiplexing sockets"
    set -l files $HOME/.ssh/+*
    if set -q files[1]
        rm $files
    end
    pkill -9 -f "$HOME/.ssh/+*" || true
end

function gemini --description "Manage and run Google Gemini CLI"
    # Configuration
    set -l install_dir "$HOME/.gemini"
    set -l bin_path "$install_dir/bin/gemini"
    set -l pkg_name "@google/gemini-cli"

    # 1. Install if not found
    if not test -f "$bin_path"
        echo "Gemini CLI not found. Installing into $install_dir..."
        mkdir -p "$install_dir"
        npm install --global --prefix "$install_dir" "$pkg_name" >/dev/null 2>&1

        if test $status -ne 0
            echo "Error: Installation failed."
            return 1
        end
    else
        # 2. Check for updates periodically (once a week)
        # Simplified: just check if it's there for now to keep it fast
    end

    # 3. Launch the binary
    eval "$bin_path" $argv
end

function agy --description 'Launch Antigravity silently via PowerShell Start-Process'
    # 1. Get Windows User
    set -l WIN_USER (powershell.exe -NoProfile -Command '$env:USERNAME' | tr -d '\r')

    # 2. Define the Windows Path to the EXE
    set -l AG_WIN_EXE "C:\Users\\$WIN_USER\AppData\Local\Programs\Antigravity\Antigravity.exe"

    # 3. Handle Arguments
    set -l TARGET_DIR "."
    if test (count $argv) -gt 0
        set TARGET_DIR $argv[1]
    end

    # 4. Resolve Absolute Linux Path
    set -l LINUX_ABS_PATH (realpath "$TARGET_DIR")

    # 5. Execute using Start-Process
    powershell.exe -NoProfile -Command "Start-Process -FilePath '$AG_WIN_EXE' -ArgumentList '--remote', 'wsl+$WSL_DISTRO_NAME', '$LINUX_ABS_PATH'"
end
