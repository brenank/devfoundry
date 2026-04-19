case "$OSTYPE" in
  darwin*)
    alias ls='ls -G'
    ;;
  *)
    alias ls='ls --color=auto'
    ;;
esac

alias l='ls -lah'
alias la='ls -la'
alias ll='ls -lh'

alias g='git'
alias v='nvim'

mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}

