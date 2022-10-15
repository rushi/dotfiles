# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="steeef"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
export UPDATE_ZSH_DAYS=30

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=~/.dotfiles/bin:$PATH

# Source all files in ~/.dotfiles/source/
function src() {
  local file
  if [ "$1" ]; then
    source "$HOME/.dotfiles/source/$1.sh"
  else
    for file in ~/.dotfiles/source/*.sh; do
      #echo "Sourcing $file"
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src
}

src

SSH_IP=$(echo $SSH_CONNECTION | awk '{print $1}')
if [[ ! -z $SSH_IP ]]; then
  echo -e "\nHello, remote visitor from $SSH_IP, you are using my zsh shell\n"
  #   noti -bkg -m "Macbook login from $SSH_IP" -t "Remote Login"
fi

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"

##
## Python (pyenv)
##
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH="/opt/homebrew/opt/php@7.2/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.2/sbin:$PATH"

# For compilers to find php@7.2 you may need to set:
#  export LDFLAGS="-L/opt/homebrew/opt/php@7.2/lib"
#  export CPPFLAGS="-I/opt/homebrew/opt/php@7.2/include"

# MongoDB
export PATH="/opt/homebrew/opt/mongodb-community-shell@4.2/bin:$PATH"

# For Elasticsearch
# See: https://github.com/Homebrew/homebrew-core/issues/100260
export JAVA_HOME="/usr/libexec/java_home -v 17"
export PATH="/opt/homebrew/opt/elasticsearch@6/bin:$PATH"

if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
fi

# bun completions
[ -s "/Users/rushi/.bun/_bun" ] && source "/Users/rushi/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"
