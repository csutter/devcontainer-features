# Copilot Instructions

## Structure

Each feature lives under `src/<feature-name>/` and has a parallel test directory at `test/<feature-name>/`:

```
src/<feature-name>/
  devcontainer-feature.json   # Metadata, mounts, env vars, postCreateCommand
  install.sh                  # Runs at image build time (root, inside container)
  NOTES.md                    # Human-written design notes — update when making meaningful changes
  README.md                   # Auto-generated — DO NOT edit directly, run `mise run docs`
test/<feature-name>/
  test.sh                     # Integration test run inside container after feature install
```

## Adding a Feature

1. Create `src/<feature-name>/devcontainer-feature.json`, `install.sh`, and `NOTES.md`
2. Add `test/<feature-name>/test.sh` covering every installed binary and configured file
3. Add the new feature to the top-level `README.md` features list
4. Run `mise run docs` to generate `src/<feature-name>/README.md`

## `install.sh` Conventions

- Shebang: `#!/usr/bin/bash`; `set -e` at the top
- Detect distro by sourcing `/etc/os-release` and switching on `$ID`
- Support Debian, Ubuntu, and Fedora at minimum; `exit 1` on unknown distros
- Watch for package name differences across distros (e.g. `openssh-client` vs `openssh-clients`)

See [src/personal-setup/install.sh](../src/personal-setup/install.sh) for the reference pattern.

## Tests

Tests use `dev-container-features-test-lib` (injected by the devcontainer test runner):

```bash
source dev-container-features-test-lib
check "label"  bash -c "..."
reportResults
```

- Add a `check` for every binary installed and every file/env var configured
- Always write tests for new functionality before considering it complete
- Run tests: `mise run test` (tests against debian, ubuntu, fedora-toolbox, devcontainers/base:ubuntu)

## Before Committing

```sh
mise run lint-shell   # ShellCheck all .sh files
mise run docs         # Regenerate README.md from devcontainer-feature.json + NOTES.md
mise run test         # Full integration test suite (requires Docker)
```

## NOTES.md

Update `src/<feature-name>/NOTES.md` when:
- Adding or removing a package and there's a non-obvious reason why
- Changing the dotfiles/mount/RCM strategy
- Documenting a tradeoff or design decision for future reference

`README.md` is auto-generated and will include the contents of `NOTES.md` — so write `NOTES.md` as if it's public-facing prose.
