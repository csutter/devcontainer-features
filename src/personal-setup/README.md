
# Personal Setup (personal-setup)

Sets up my desired software and configuration for any devcontainer environment.

## Example Usage

```json
"features": {
    "ghcr.io/csutter/devcontainer-features/personal-setup:2": {}
}
```



I have a set of preferred tools that I want available in any devcontainer, as well as several
dotfiles repositories to configure my desired development environment.

I've previously (ab)used the _Dev Containers_ extension's built in dotfiles support, but it:
- doesn't allow multiple dotfiles repositories (a key use case for me)
- relies on an install script in the repository (which feels like an unsuitable concern for a
  repository of configuration files)
- clones the repository from origin every time (which requires SSH agent confirmation and needs
  "human in the loop" during setup, and means changes on the host don't get picked up until push and
  a full container rebuild)

This feature:
- Installs a set of packages in the container (including `rcm` for dotfiles management)
- Mounts my dotfiles repositories into the container
- Copies in an `rcrc` for dotfiles configuration, including:
  - setting the correct tags and dotfiles mount locations
  - avoiding setting up git config (as VS Code will copy it into the container anyway with
    modifications, which would modify our canonical dotfiles version with transient,
    container-specific setup)
- Installs the dotfiles

This feature is intended to be configured as part of my personal user settings as a default feature
for all devcontainers (through `dev.containers.defaultFeatures`). It's obviously specific to me,
and coupled to my canonical directory layout and dotfiles repositories.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
