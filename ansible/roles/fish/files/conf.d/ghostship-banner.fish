#!/usr/bin/fish

# Modern system banner using fastfetch
function fish_greeting -d "Ghostship Welcome Banner"
    if type -q fastfetch
        fastfetch --structure "Title:Separator:OS:Host:Kernel:Uptime:Packages:Shell:Terminal:CPU:GPU:Memory:Swap:Disk:LocalIp:Battery:Break:Colors"
    end
    set_color normal
end
