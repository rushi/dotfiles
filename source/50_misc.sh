export GREP_OPTIONS='--color=auto'

# Set the terminal's title bar.
function titlebar() {
  echo -n $'\e]0;'"$*"$'\a'
}

alias ps\?="ps aux | grep -i"
alias ka="killall"
