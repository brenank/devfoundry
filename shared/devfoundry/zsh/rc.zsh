emulate -L zsh

setopt auto_cd
setopt interactive_comments
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history
setopt prompt_subst

if [[ -d "${XDG_STATE_HOME:-$HOME/.local/state}" ]]; then
  HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
else
  HISTFILE="$HOME/.zsh_history"
fi

HISTSIZE=10000
SAVEHIST=10000

typeset -U path PATH fpath FPATH

source_first_existing() {
  local candidate

  for candidate in "$@"; do
    if [[ -n "${candidate}" && -r "${candidate}" ]]; then
      source "${candidate}"
      return 0
    fi
  done

  return 1
}

if [[ -n "${DEVFOUNDRY_ZSH_COMPLETIONS_DIR:-}" && -d "${DEVFOUNDRY_ZSH_COMPLETIONS_DIR}" ]]; then
  fpath=("${DEVFOUNDRY_ZSH_COMPLETIONS_DIR}" $fpath)
elif [[ -d "${DEVFOUNDRY_USER_PLUGIN_HOME}/zsh-completions/src" ]]; then
  fpath=("${DEVFOUNDRY_USER_PLUGIN_HOME}/zsh-completions/src" $fpath)
elif [[ -d "${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/zsh-completions/src" ]]; then
  fpath=("${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/zsh-completions/src" $fpath)
fi

autoload -Uz compinit
zmodload zsh/complist

compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump-${HOST%%.*}-${ZSH_VERSION}"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

source_first_existing \
  "${DEVFOUNDRY_SYSTEM_HOME}/zsh/aliases.zsh" \
  "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/aliases.zsh"

source_first_existing \
  "${DEVFOUNDRY_POWERLEVEL10K_THEME:-}" \
  "${DEVFOUNDRY_USER_PLUGIN_HOME}/powerlevel10k/powerlevel10k.zsh-theme" \
  "${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/powerlevel10k/powerlevel10k.zsh-theme"

source_first_existing \
  "${DEVFOUNDRY_ZSH_AUTOSUGGESTIONS:-}" \
  "${DEVFOUNDRY_USER_PLUGIN_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh"

source_first_existing \
  "$HOME/.p10k.zsh" \
  "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/p10k.zsh" \
  "${DEVFOUNDRY_SYSTEM_HOME}/zsh/p10k.zsh"

source_first_existing \
  "${DEVFOUNDRY_ZSH_SYNTAX_HIGHLIGHTING:-}" \
  "${DEVFOUNDRY_USER_PLUGIN_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" \
  "${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
