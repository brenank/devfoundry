typeset -U path PATH

path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  $path
)

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less -FRX}"
export LESSHISTFILE=-
