.PHONY: help docs lint-shell test

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

docs: ## Generate documentation for all features
	devcontainer features generate-docs -p src -n csutter/devcontainer-features

lint-shell: ## Lint all shell scripts using ShellCheck
	find . -name '*.sh' -print0 | xargs -0 shellcheck

test: ## Run tests for all features
	devcontainer features test -i docker.io/library/debian:latest
	devcontainer features test -i docker.io/library/ubuntu:latest
	devcontainer features test -i quay.io/fedora/fedora-toolbox:latest
	devcontainer features test -i mcr.microsoft.com/devcontainers/base:ubuntu
