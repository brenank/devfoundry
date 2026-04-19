#!/usr/bin/env bash
set -euo pipefail

repo_root="$(CDPATH= cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="${repo_root}/shared/devfoundry/zsh/plugins.txt"
plugin_home="${XDG_DATA_HOME:-${HOME}/.local/share}/devfoundry/plugins"

mkdir -p "${plugin_home}"

while read -r name url; do
  if [[ -z "${name:-}" || "${name:0:1}" == "#" ]]; then
    continue
  fi

  destination="${plugin_home}/${name}"

  if [[ -d "${destination}/.git" ]]; then
    git -C "${destination}" pull --ff-only
  else
    git clone --depth=1 "${url}" "${destination}"
  fi
done < "${manifest}"
