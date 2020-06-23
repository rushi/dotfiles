export PATH

# rbenv init.
PATH=$(path_remove ~/.dotfiles/libs/rbenv/bin):~/.dotfiles/libs/rbenv/bin
PATH=$(path_remove ~/.dotfiles/libs/ruby-build/bin):~/.dotfiles/libs/ruby-build/bin

# Removed && [ ! "$(type _rbenv)" ] not sure what it does right now, but it doesnt work on zsh
if [ "$(type rbenv)" ]; then
  eval "$(rbenv init -)"
fi

alias py="python"
alias composer="php -d memory_limit=-1 ~/.dotfiles/bin/composer"

# Symfony
alias sf='php bin/console --no-debug'
alias sfcl='sf cache:clear'
alias sfapc='sf apc:clear'
alias xpu='xolaphpunit'
alias flushlogs='cat /dev/null > var/logs/*.log;wc -l var/logs/*.log'

# run unit tests
function xolaphpunit() {
    vendor/phpunit/phpunit/phpunit -c phpunit.xml.dist --debug -d memory_limit=4096M "$@"
}

# Remove stuff from symfony's email spool
function clearspool() {
    rm -rf app/spool/default/
    mkdir -p app/spool/default/
    ls -a app/spool/default/
}

## NODEJS
alias npr="npm --silent run"
alias npmls="npm ls --depth=0"
