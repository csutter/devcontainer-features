#!/bin/bash
set -e

source dev-container-features-test-lib

check "delta is available"      bash -c "which delta"
check "fzf is available"        bash -c "which fzf"
check "rcm is available"        bash -c "which rcup"
check "ssh is available"        bash -c "which ssh"
check "tree is available"       bash -c "which tree"
# Use a dotfile that should _always_ be present on any system
check "dotfiles are installed"  bash -c "test -f $HOME/.config/fish/config.fish"
check "rcrc is present"         bash -c "test -f /etc/rcrc"
check "_IS_DEVCONTAINER is set" bash -c "test \"\$_IS_DEVCONTAINER\" = \"true\""

reportResults
