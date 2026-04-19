#!/usr/bin/env bash
set -euo pipefail

repo_root="$(CDPATH= cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v chezmoi >/dev/null 2>&1; then
  echo "chezmoi is required but was not found in PATH" >&2
  exit 1
fi

"${repo_root}/scripts/sync-shared-user-config.sh" "$@"
"${repo_root}/scripts/ensure-local-overrides.sh"
chezmoi init --apply --source="${repo_root}/home"
