# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
PATH=/usr/local/bin:$(path_remove /usr/local/bin)
# Add Homebrew path
PATH=/usr/local/sbin:$PATH
PATH=/Applications/MAMP/bin/php/current_php/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH
export PATH

MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export MANPATH

alias ql="quicklook"

# Make 'less' more.
# eval "$(lesspipe.sh)"

alias pf="open -a 'Path Finder'"
alias mysql="mysql --socket=/Applications/MAMP/tmp/mysql/mysql.sock"
alias top="htop" # Install this through homebrew
alias bs="brew services"

# MAMP Apache
alias mampctl="sudo /Applications/MAMP/Library/bin/apachectl"
export MAMPLOGS="/Applications/MAMP/logs"

alias log_php="tail -f $MAMPLOGS/php_error.log"
alias log_apache="tail -f $MAMPLOGS/apache_error.log"
alias log_access="tail -f $MAMPLOGS/apache_access.log"
alias log_all="tail -f $MAMPLOGS/*.log"

#alias rm="trash"
