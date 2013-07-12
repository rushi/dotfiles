export PATH

# Add Stuff here to configure Node/NPM


# rbenv init.
PATH=$(path_remove ~/.dotfiles/libs/rbenv/bin):~/.dotfiles/libs/rbenv/bin
PATH=$(path_remove ~/.dotfiles/libs/ruby-build/bin):~/.dotfiles/libs/ruby-build/bin

# Removed && [ ! "$(type _rbenv)" ] not sure what it does right now, but it doesnt work on zsh
if [ "$(type rbenv)" ]; then
  eval "$(rbenv init -)"
fi

alias py="python"
