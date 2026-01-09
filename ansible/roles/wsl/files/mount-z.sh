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
        # Validate environment variables
        if [ -z "$SMB_SERVER" ] || [ -z "$SMB_SHARE" ] || [ -z "$SMB_USER" ] || [ -z "$SMB_PASS" ]; then
            echo "Error: Missing required environment variables (SMB_SERVER, SMB_SHARE, SMB_USER, SMB_PASS)."
            exit 1
        fi

        echo "Mounting ${SMB_SERVER}/${SMB_SHARE} to /mnt/z..."
        if mount -t cifs "//${SMB_SERVER}/${SMB_SHARE}" /mnt/z -o "username=${SMB_USER},password=${SMB_PASS},uid=$(id -u),gid=$(id -g),vers=3.0,iocharset=utf8,rsize=1048576,wsize=1048576,actimeo=60"; then
            echo "Mount successful."
        else
            echo "Mount failed."
            exit 1
        fi
    fi
else
    echo "Z: drive not found in Windows."
fi
