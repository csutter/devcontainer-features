#!/bin/bash
set -e

source dev-container-features-test-lib

# Check packages are installed and available
check "curl is available"         bash -c "which curl"
check "delta is available"        bash -c "which delta"
check "fd is available"           bash -c "which fd || which fdfind"
check "fish is available"         bash -c "which fish"
check "jq is available"           bash -c "which jq"
check "less is available"         bash -c "which less"
check "rcm is available"          bash -c "which rcup"
check "ripgrep is available"      bash -c "which rg"
check "ssh is available"          bash -c "which ssh"
check "tree is available"         bash -c "which tree"

# Check dotfiles are installed
check "dotfiles are installed"  bash -c "test -f $HOME/.rcrc"

# Check environment variables are set
check "_IS_DEVCONTAINER is set" bash -c "test \"\$_IS_DEVCONTAINER\" = \"true\""
check "PROMPT_PREFIX is set"    bash -c "test \"\$PROMPT_PREFIX\" = \"\""

reportResults
