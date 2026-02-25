#!/usr/bin/bash
set -e

if [ -f /etc/os-release ]; then
    . /etc/os-release
else
    echo "Error: Cannot detect distribution (no /etc/os-release)"
    exit 1
fi

echo "Installing packages for distribution: $ID"
case "$ID" in
    debian|ubuntu)
        apt-get update
        apt-get install -y fish git-delta rcm tree openssh-client
        ;;
    fedora)
        dnf install -y fish git-delta rcm tree openssh-clients
        ;;
    *)
        echo "Error: Unsupported distribution: $ID"
        echo "This feature supports: debian, ubuntu, fedora"
        exit 1
        ;;
esac
