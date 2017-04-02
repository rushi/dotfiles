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
alias sf='php app/console --no-debug'
alias sfcl='sf cache:clear'
alias sfapc='sf apc:clear'
alias xpu='xolaphpunit'
alias flushlogs='cat /dev/null > app/logs/*.log;wc -l app/logs/*.log'
alias gh="hub"

alias mt="multitail -c -D"
alias sft="multitail -c -D -ev deprecate"

# run unit tests
function xolaphpunit() {
    set +x
    phpunit -c app/phpunit.xml --debug -d memory_limit=4096M -d zend.enable_gc=0 "$@"
    set -x
}

# Remove stuff from symfony's email spool
function clearspool() {
    rm -rf app/spool/default/
    mkdir -p app/spool/default/
    ls -a app/spool/default/
}
