#!/usr/bin/fish

# Command Not Found Handlers
# Priority: find-the-command > pkgfile

if test -f /usr/share/doc/find-the-command/ftc.fish
    # find-the-command is more modern and feature-rich for interactive use
    # Flags: 
    #   noprompt: Don't ask to install, just show the command
    #   quiet: Less verbose output
    #   info: Show package description
    source /usr/share/doc/find-the-command/ftc.fish noprompt noupdate quiet info
else if test -f /usr/share/doc/pkgfile/command-not-found.fish
    # Fallback to pkgfile if find-the-command is missing
    source /usr/share/doc/pkgfile/command-not-found.fish
end
