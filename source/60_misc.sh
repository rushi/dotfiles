export GREP_OPTIONS='--color=auto'

alias ka="killall"
alias youtube-dl-audio="youtube-dl --no-mtime -f 'bestaudio[ext=m4a]'"

function ps_search() {
    # ps aux | grep -i $1 | grep -v grep
    echo -e "$fg_bold[grey]# Using 'procs --sortd cpu $1' instead$reset_color"
    # echo -e "# Useful args: $fg[gray]--or, --and, --watch, --tree, --sortd cpu|memory$reset_color"
    procs --sortd cpu $1
}

alias ps\?="ps_search"
