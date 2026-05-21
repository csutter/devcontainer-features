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
        apt-get install -y cloc curl fd-find fish git-delta jq less openssh-client rcm ripgrep tree
        ;;
    fedora)
        dnf install -y cloc curl fd-find fish git-delta jq less openssh-clients rcm ripgrep tree
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

# Some devcontainer configurations outside my control explicitly set zsh as the default shell, and
# to add insult to injury, install the unspeakable abomination that is `oh-my-zsh`.
echo "Purge oh-my-zsh and enforce fish as the default shell"
rm -rf "${_REMOTE_USER_HOME}/.oh-my-zsh"
chsh -s "$(which fish)" "${_REMOTE_USER}"
