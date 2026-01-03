#!/bin/bash

# Check if Z: drive is available in Windows
if /mnt/c/Windows/System32/cmd.exe /c "IF EXIST Z:\ (EXIT 0) ELSE (EXIT 1)"; then
    echo "Z: drive detected in Windows."
    
    # Create mount point if it doesn't exist
    if [ ! -d "/mnt/z" ]; then
        echo "Creating /mnt/z..."
        mkdir -p /mnt/z
    fi

    # Check if already mounted
    if mountpoint -q /mnt/z; then
        echo "/mnt/z is already mounted."
    else
        echo "Mounting Z: to /mnt/z..."
        mount -t drvfs Z: /mnt/z
    fi
else
    echo "Z: drive not found in Windows."
fi
