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
        apt-get install -y curl fd-find fish git-delta jq less openssh-client rcm ripgrep tree
        ;;
    fedora)
        dnf install -y curl fd-find fish git-delta jq less openssh-clients rcm ripgrep tree
        ;;
    *)
        echo "Error: Unsupported distribution: $ID"
        echo "This feature supports: debian, ubuntu, fedora"
        exit 1
        ;;
esac

echo "Setting up rcm configuration for user: $_REMOTE_USER"
cat > "$_REMOTE_USER_HOME/.rcrc" <<'EOF'
EXCLUDES="README.md"
DOTFILES_DIRS="/mnt/dotfiles /mnt/dotfiles-private"
TAGS="devcontainer"
EOF
