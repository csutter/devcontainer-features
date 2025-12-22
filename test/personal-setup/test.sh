#!/bin/bash
set -e

source dev-container-features-test-lib

check "fish is available"       bash -c "which fish"
check "rcm is available"        bash -c "which rcup"
check "tree is available"       bash -c "which tree"
# Use a dotfile that should _always_ be present on any system
check "dotfiles are installed"  bash -c "test -f $HOME/.config/fish/config.fish"

reportResults
