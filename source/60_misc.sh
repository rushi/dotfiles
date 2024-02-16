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
alias bwatch="batwatch --no-clear --color --style=plain --command"

alias bathelp='bat --plain --language=help'
help() {
    # TODO: "help git commit" doesn't work due to ${*}
    setopt null_glob

    filename="${*}"
    for file in "$filename"*; do
        if [[ -f $file ]]; then
            chalk -t "Found file: {green $file}"
            "./${file}" --help 2>&1 | bathelp
            unsetopt null_glob
            return
        fi
    done

    "$filename" --help 2>&1 | bathelp
    unsetopt null_glob
}
