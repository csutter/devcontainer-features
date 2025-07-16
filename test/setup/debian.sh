#!/bin/bash
set -e

source dev-container-features-test-lib

# Test that lsrc command is available after installation
check "lsrc command is available" lsrc -V

reportResults
