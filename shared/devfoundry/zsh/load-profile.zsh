if [[ -n "${DEVFOUNDRY_PROFILE_LOADED:-}" ]]; then
  return 0
fi

typeset -g DEVFOUNDRY_PROFILE_LOADED=1

if [[ -r "${DEVFOUNDRY_SYSTEM_HOME}/zsh/profile.zsh" ]]; then
  source "${DEVFOUNDRY_SYSTEM_HOME}/zsh/profile.zsh"
elif [[ -r "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/profile.zsh" ]]; then
  source "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/profile.zsh"
fi

[[ -r "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/host.profile.zsh" ]] && source "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/host.profile.zsh"
[[ -r "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/local.profile.zsh" ]] && source "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/local.profile.zsh"
