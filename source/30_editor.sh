# Editing
export EDITOR='vim'
export VISUAL="$EDITOR"

# export LESS="-FXRM~gIsw"
# export LESS_TERMCAP_mb=$'\E[01;31m'
# export LESS_TERMCAP_md=$'\E[01;31m'
# export LESS_TERMCAP_me=$'\E[0m'
# export LESS_TERMCAP_se=$'\E[0m'
# export LESS_TERMCAP_so=$'\E[01;44;33m'
# export LESS_TERMCAP_ue=$'\E[0m'
# export LESS_TERMCAP_us=$'\E[01;32m'

# Prevent less from clearing the screen while still showing colors.
# export LESS="-FXRMgIsw"

alias c="code ."
alias vi="vim"
alias cat="bat -p"
# bat has same functionoality
alias less="bat"
export PAGER="bat -p"