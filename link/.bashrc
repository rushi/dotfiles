#### FIG ENV VARIABLES ####
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
# Add binaries into the path
PATH=~/.dotfiles/bin:$PATH
export PATH

# Source all files in ~/.dotfiles/source/
function src() {
  local file
  if [[ "$1" ]]; then
    source "$HOME/.dotfiles/source/$1.sh"
  else
    for file in ~/.dotfiles/source/*; do
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src
}

# Not needed since I don't use bash
src
SSH_IP=`echo $SSH_CONNECTION | awk '{print $1}'`
if [[ ! -z $SSH_IP ]]; then
    echo "Hello, remote visitor from $SSH_IP. You are using my bash shell"
    noti -bkg -m "Macbook login from $SSH_IP" -t "Remote Login"
fi


#### FIG ENV VARIABLES ####
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####



[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sheval "$(atuin init bash)"
