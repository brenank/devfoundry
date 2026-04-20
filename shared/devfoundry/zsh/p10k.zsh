# Managed by devfoundry shared defaults.

typeset -g POWERLEVEL9K_MODE='nerdfont-v3'
typeset -g POWERLEVEL9K_ICON_PADDING=none
typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  os_icon
  dir
  vcs
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status
  command_execution_time
  background_jobs
  direnv
  asdf
  virtualenv
  anaconda
  pyenv
  goenv
  nodenv
  nvm
  nodeenv
  rbenv
  rvm
  fvm
  luaenv
  jenv
  plenv
  perlbrew
  phpenv
  scalaenv
  haskell_stack
  kubecontext
  terraform
  aws
  aws_eb_env
  azure
  gcloud
  google_app_cred
  toolbox
  context
  ranger
  yazi
  nnn
  lf
  xplr
  vim_shell
  midnight_commander
  nix_shell
  chezmoi_shell
  vi_mode
  todo
  timewarrior
  taskwarrior
  per_directory_history
)

typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=false
typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%244F\uE0B1'
typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%244F\uE0B3'
typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B0'
typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B2'
typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B0'
typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B2'
typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''
typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=

typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=255
typeset -g POWERLEVEL9K_DIR_FOREGROUND=31
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY='truncate_to_unique'
typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80

typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=76
typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=178

typeset -g POWERLEVEL9K_STATUS_OK=true
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=70
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=160

typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0

typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
