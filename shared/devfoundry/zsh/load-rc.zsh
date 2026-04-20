if [[ -n "${DEVFOUNDRY_RC_LOADED:-}" ]]; then
  return 0
fi

typeset -g DEVFOUNDRY_RC_LOADED=1

if [[ -r "${DEVFOUNDRY_SYSTEM_HOME}/zsh/rc.zsh" ]]; then
  source "${DEVFOUNDRY_SYSTEM_HOME}/zsh/rc.zsh"
elif [[ -r "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/rc.zsh" ]]; then
  source "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/rc.zsh"
fi

[[ -r "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/host.zsh" ]] && source "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/host.zsh"
[[ -r "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/local.zsh" ]] && source "${DEVFOUNDRY_USER_CONFIG_HOME}/zsh/local.zsh"
