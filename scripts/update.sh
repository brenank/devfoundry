#!/usr/bin/env bash
set -euo pipefail

repo_root="$(CDPATH= cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

git -C "${repo_root}" pull --ff-only
"${repo_root}/scripts/install-zsh-plugins.sh"
"${repo_root}/scripts/apply.sh" "$@"
