# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bashrc.pre.bash" ]] && . "$HOME/.fig/shell/bashrc.pre.bash"
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
SSH_IP=$(echo $SSH_CONNECTION | awk '{print $1}')
if [[ ! -z $SSH_IP ]]; then
  echo "Hello, remote visitor from $SSH_IP. You are using my bash shell"
  # noti -bkg -m "Macbook login from $SSH_IP" -t "Remote Login"
fi

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sheval "$(atuin init bash)"

alias rni="kill $(lsof -t -i:8081); rm -rf ios/build/; react-native run-ios"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bashrc.post.bash" ]] && . "$HOME/.fig/shell/bashrc.post.bash"

source /Users/rushi/.config/broot/launcher/bash/br
