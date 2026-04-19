# devfoundry

Portable developer-environment source of truth for shell, Git, and related user configuration.

`devfoundry` is built around one idea: keep portable developer defaults separate from machine configuration, but make those defaults usable in two modes:

- **system-default mode** on NixOS via `/etc/devfoundry`
- **user-owned mode** on any machine via `chezmoi`

This keeps the repo portable across NixOS, generic Linux, and future macOS, while still letting NixOS provide a polished default experience for every user on the machine.

## Executive summary

- `shared/devfoundry/` is the source of truth for shared Git and Zsh defaults.
- `home/` contains only thin user-level wrappers managed by `chezmoi`.
- NixOS can publish `shared/devfoundry/` into `/etc/devfoundry` for all users.
- In user-owned mode, managed shared files are published under `~/.local/share/devfoundry`.
- User overrides always live under `~/.config/devfoundry` and win last.

## Why `chezmoi`

`chezmoi` is the recommended manager for the user-owned layer because it handles:

- first-run bootstrapping
- idempotent apply
- multi-machine workflows
- templating when needed later
- clean dotfile ownership without symlink sprawl

Compared with `stow`, it is a better fit once you want host-aware behavior and clean installation flows.

## Why not Antidote by default

`antidote` is fast and well-maintained, but it is not the default in this repo.

Defaulting to direct-managed plugins keeps the shared shell startup model simpler:

- no runtime plugin-manager dependency
- fewer path assumptions across Linux and macOS
- easier NixOS integration, because Nix can provide plugin files directly
- easier debugging when shell startup breaks

An optional Antidote plugin list still lives at `examples/antidote/plugins.txt` if you want to switch later.

## Repository layout

- `shared/devfoundry/` — shared Git and Zsh defaults used by both NixOS and user mode
- `home/` — `chezmoi`-managed home wrappers such as `~/.zshrc` and `~/.gitconfig`
- `scripts/` — bootstrap, sync, apply, and update helpers
- `examples/` — unmanaged override templates for user and machine customization
- `nix/examples/` — example NixOS and Home Manager integration

## Shared versus machine config

### Keep in `devfoundry`

- shared shell defaults
- shared prompt config
- shared Git defaults and aliases
- portable bootstrap scripts
- override file templates

### Keep in the NixOS or machine repo

- packages and package versions
- system services
- hardware configuration
- networking, boot, disks, secrets, users
- machine-wide `/etc` policy not specific to developer ergonomics

## Override model

Shared config comes from one of two places:

- `/etc/devfoundry` when NixOS publishes system defaults
- `~/.local/share/devfoundry` when you apply the repo in user-owned mode

User overrides always live in `~/.config/devfoundry`:

- `~/.config/devfoundry/git/host.gitconfig`
- `~/.config/devfoundry/git/local.gitconfig`
- `~/.config/devfoundry/zsh/host.profile.zsh`
- `~/.config/devfoundry/zsh/local.profile.zsh`
- `~/.config/devfoundry/zsh/host.zsh`
- `~/.config/devfoundry/zsh/local.zsh`

Precedence is explicit:

- Git: system shared defaults or generated user shared defaults load first, then host override, then local override.
- Zsh: shared profile and rc load first, then host override, then local override.
- Prompt: `~/.p10k.zsh` wins if present; otherwise the shared `devfoundry` `p10k` config is used.

This preserves the normal “last definition wins” behavior and keeps local experiments out of the shared baseline.

## Install flows

### NixOS system-default mode

Use your NixOS repo to:

- install `git`, `zsh`, `chezmoi`, `neovim`, and desired CLI tools
- publish `shared/devfoundry` into `/etc/devfoundry`
- source `/etc/devfoundry/zsh/load-profile.zsh` and `/etc/devfoundry/zsh/load-rc.zsh`
- include `/etc/devfoundry/git/base.gitconfig` and `/etc/devfoundry/git/aliases.gitconfig` from `/etc/gitconfig`

In this mode, new users get the baseline automatically. They only need personal overrides if they want them.

### Existing Linux machine

Install the prerequisites with your package manager:

- `git`
- `zsh`
- `chezmoi`

Then:

```bash
git clone <your-devfoundry-repo-url> ~/repos/devfoundry
cd ~/repos/devfoundry
./scripts/install-zsh-plugins.sh
./scripts/apply.sh
```

### Future macOS machine

Install the same prerequisites with Homebrew, then use the same flow:

```bash
git clone <your-devfoundry-repo-url> ~/repos/devfoundry
cd ~/repos/devfoundry
./scripts/install-zsh-plugins.sh
./scripts/apply.sh
```

## Scripts

- `./scripts/apply.sh` — syncs shared config into `~/.local/share/devfoundry`, ensures override files exist, and applies `chezmoi`
- `./scripts/install-zsh-plugins.sh` — installs the small default plugin set into `~/.local/share/devfoundry/plugins`
- `./scripts/update.sh` — pulls the repo, refreshes plugins, and reapplies config

If `/etc/devfoundry` already exists, `apply.sh` keeps relying on the system shared layer, removes old mixed-layout shared files from `~/.config/devfoundry`, and only prepares user overrides.

## NixOS integration

The reference module example is in `nix/examples/nixos-devfoundry.nix`.

Recommended pattern:

- make your NixOS repo consume this repo as a flake input, submodule, or vendored path
- publish `shared/devfoundry` into `/etc/devfoundry`
- install Zsh plugins from Nix packages, not a runtime manager
- leave identity and personal aliases in user overrides

This gives all users a sensible default experience while preserving home-directory override behavior.

## Maintenance guidance

- keep shared defaults conservative and boring
- put one-off machine behavior into `host.*`
- put personal experiments into `local.*`
- only promote settings into shared config after they prove useful on multiple machines
- prefer Nix packages for the NixOS system layer and repo-managed plugin installs elsewhere
