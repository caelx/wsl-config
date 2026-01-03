#!/usr/bin/fish

# Direnv integration
if type -q direnv
    direnv hook fish | source
end
