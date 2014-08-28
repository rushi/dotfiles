# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
PATH=/usr/local/bin:$(path_remove /usr/local/bin)
# Add Homebrew path
PATH=/usr/local/sbin:$PATH
PATH=/Applications/MAMP/bin/php/php5.5.10/bin:$PATH
export PATH

alias ql="quicklook"

# Make 'less' more.
eval "$(lesspipe.sh)"

# Start ScreenSaver. This will lock the screen if locking is enabled.
alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"

alias pf="open -a 'Path Finder'"
alias mysql="mysql --socket=/Applications/MAMP/tmp/mysql/mysql.sock"
alias top="htop" # Install this through homebrew

function server_start() {
    sudo sh /Applications/MAMP/bin/startApache.sh
    sh /Applications/MAMP/bin/startMysql.sh
}

function server_stop() {
    sudo sh /Applications/MAMP/bin/stop.sh
}

function log_php() {
    tail -f /Applications/MAMP/logs/php_error.log
}

function log_apache() {
    tail -f /Applications/MAMP/logs/apache_error_log
}

function log_access() {
    tail -f /Applications/MAMP/logs/apache_access_log
}
