export PATH

# rbenv init.
PATH=$(path_remove ~/.dotfiles/libs/rbenv/bin):~/.dotfiles/libs/rbenv/bin
PATH=$(path_remove ~/.dotfiles/libs/ruby-build/bin):~/.dotfiles/libs/ruby-build/bin

# Removed && [ ! "$(type _rbenv)" ] not sure what it does right now, but it doesnt work on zsh
if [ "$(type rbenv)" ]; then
  eval "$(rbenv init -)"
fi

alias py="python"

# Symfony
alias console='php app/console'
alias xpu='xolaphpunit'
alias flushlogs='cat /dev/null > app/logs/*.log;wc -l app/logs/*.log'

# run unit tests
function xolaphpunit() {
    set +x
    phpunit -c app/phpunit.xml.dist --debug -d memory_limit=2048M "$@"
    set -x
}

# Remove stuff from symfony's email spool
function clearspool() {
    rm -rf app/spool/default/*
    rm -rf app/spool/default/.*
    ls -a app/spool/default/
}
