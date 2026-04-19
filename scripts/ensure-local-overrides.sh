#!/usr/bin/env bash
set -euo pipefail

repo_root="$(CDPATH= cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

refresh_legacy_git_host_override() {
  local target_file="$1"
  local source_file="$2"
  local legacy_contents
  local target_contents

  if [[ ! -e "${target_file}" ]]; then
    return 0
  fi

  legacy_contents=$(cat <<'EOF'
# Machine-specific Git overrides.
# This file is not managed by chezmoi after it is copied into your home directory.

[core]
    editor = nvim
EOF
)

  target_contents="$(cat "${target_file}")"

  if [[ "${target_contents}" == "${legacy_contents}" ]]; then
    cp "${source_file}" "${target_file}"
    echo "updated legacy ${target_file}"
  fi
}

copy_if_missing() {
  local source_file="$1"
  local target_file="$2"

  mkdir -p "$(dirname "${target_file}")"

  if [[ ! -e "${target_file}" ]]; then
    cp "${source_file}" "${target_file}"
    echo "created ${target_file}"
  fi
}

copy_if_missing \
  "${repo_root}/examples/git/host.gitconfig" \
  "${HOME}/.config/devfoundry/git/host.gitconfig"

refresh_legacy_git_host_override \
  "${HOME}/.config/devfoundry/git/host.gitconfig" \
  "${repo_root}/examples/git/host.gitconfig"

copy_if_missing \
  "${repo_root}/examples/git/local.gitconfig" \
  "${HOME}/.config/devfoundry/git/local.gitconfig"

copy_if_missing \
  "${repo_root}/examples/zsh/host.profile.zsh" \
  "${HOME}/.config/devfoundry/zsh/host.profile.zsh"

copy_if_missing \
  "${repo_root}/examples/zsh/local.profile.zsh" \
  "${HOME}/.config/devfoundry/zsh/local.profile.zsh"

copy_if_missing \
  "${repo_root}/examples/zsh/host.zsh" \
  "${HOME}/.config/devfoundry/zsh/host.zsh"

copy_if_missing \
  "${repo_root}/examples/zsh/local.zsh" \
  "${HOME}/.config/devfoundry/zsh/local.zsh"
