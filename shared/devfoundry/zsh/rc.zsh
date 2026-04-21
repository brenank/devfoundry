setopt auto_cd
setopt interactive_comments
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history
setopt prompt_subst

history_dir="${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
if mkdir -p "${history_dir}" 2>/dev/null; then
  HISTFILE="${history_dir}/history"
else
  HISTFILE="$HOME/.zsh_history"
fi

HISTSIZE=10000
SAVEHIST=10000

typeset -U path PATH fpath FPATH

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

if [[ -r "${DEVFOUNDRY_SYSTEM_HOME}/zsh/aliases.zsh" ]]; then
  source "${DEVFOUNDRY_SYSTEM_HOME}/zsh/aliases.zsh"
elif [[ -r "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/aliases.zsh" ]]; then
  source "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/aliases.zsh"
fi

if [[ "${TERM:-}" == "linux" ]]; then
  # The Linux virtual console cannot render the Nerd Font glyphs expected by p10k.
  PROMPT='%F{cyan}%n@%m%f:%F{blue}%~%f %# '
  RPROMPT=
elif [[ -n "${DEVFOUNDRY_POWERLEVEL10K_THEME:-}" && -r "${DEVFOUNDRY_POWERLEVEL10K_THEME}" ]]; then
  source "${DEVFOUNDRY_POWERLEVEL10K_THEME}"
elif [[ -r "${DEVFOUNDRY_USER_PLUGIN_HOME}/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "${DEVFOUNDRY_USER_PLUGIN_HOME}/powerlevel10k/powerlevel10k.zsh-theme"
elif [[ -r "${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/powerlevel10k/powerlevel10k.zsh-theme"
fi

if [[ -n "${DEVFOUNDRY_ZSH_AUTOSUGGESTIONS:-}" && -r "${DEVFOUNDRY_ZSH_AUTOSUGGESTIONS}" ]]; then
  source "${DEVFOUNDRY_ZSH_AUTOSUGGESTIONS}"
elif [[ -r "${DEVFOUNDRY_USER_PLUGIN_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "${DEVFOUNDRY_USER_PLUGIN_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [[ -r "${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [[ "${TERM:-}" != "linux" ]]; then
  if [[ -r "$HOME/.p10k.zsh" ]]; then
    source "$HOME/.p10k.zsh"
  elif [[ -r "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/p10k.zsh" ]]; then
    source "${DEVFOUNDRY_USER_SHARE_HOME}/zsh/p10k.zsh"
  elif [[ -r "${DEVFOUNDRY_SYSTEM_HOME}/zsh/p10k.zsh" ]]; then
    source "${DEVFOUNDRY_SYSTEM_HOME}/zsh/p10k.zsh"
  fi
fi

if [[ -n "${DEVFOUNDRY_ZSH_SYNTAX_HIGHLIGHTING:-}" && -r "${DEVFOUNDRY_ZSH_SYNTAX_HIGHLIGHTING}" ]]; then
  source "${DEVFOUNDRY_ZSH_SYNTAX_HIGHLIGHTING}"
elif [[ -r "${DEVFOUNDRY_USER_PLUGIN_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "${DEVFOUNDRY_USER_PLUGIN_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [[ -r "${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "${DEVFOUNDRY_SYSTEM_PLUGIN_HOME}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Zsh chooses the initial ZLE keymap from EDITOR/VISUAL. Since `nvim` contains
# `vi`, shells can silently start with vi insert bindings unless we select the
# desired editing mode explicitly.
bindkey -e

# Make sure the terminal's Delete and Backspace keys do the expected thing in
# the active emacs keymap, even when the terminal sends different sequences.
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
