# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
PATH=/usr/local/bin:$(path_remove /usr/local/bin)
# Add Homebrew path
PATH=/usr/local/sbin:$PATH
export PATH

alias ql="quicklook"

# Make 'less' more.
# eval "$(lesspipe.sh)"

alias pf="open -a 'Path Finder'"
alias top="htop" # Install this through homebrew
alias bs="brew services"

# npm install --global trash-cli
alias rm="trash"
HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=true
HOMEBREW_NO_AUTO_UPDATE=true
