if [[ -n "${DEVFOUNDRY_PROFILE_LOADED:-}" ]]; then
  return 0
fi

typeset -g DEVFOUNDRY_PROFILE_LOADED=1

devfoundry_source_first_existing() {
  local candidate

  for candidate in "$@"; do
    if [[ -n "${candidate}" && -r "${candidate}" ]]; then
      source "${candidate}"
      return 0
    fi
  done

  return 1
}

devfoundry_source_first_existing \
  "${DEVFOUNDRY_SYSTEM_HOME}/zsh/profile.zsh" \
  "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/profile.zsh"

[[ -r "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/host.profile.zsh" ]] && source "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/host.profile.zsh"
[[ -r "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/local.profile.zsh" ]] && source "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/local.profile.zsh"
