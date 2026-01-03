#!/usr/bin/fish

# Automatic ls on directory change
function __ghostship_autols_hook --on-variable PWD --description "Auto ls on directory change"
    if status is-interactive
        if type -q lsd
            lsd --group-directories-first --icon never --human-readable
        else
            ls --color -h --group-directories-first -p
        end
    end
end
