#!/bin/bash

export GREP_OPTIONS='--color=auto'

function ps_search() {
    # ps aux | grep -i $1 | grep -v grep
    echo -e "${fg_bold[grey]}# Using 'procs --sortd cpu $1' instead${reset_color}"
    # echo -e "# Useful args: $fg[gray]--or, --and, --watch, --tree, --sortd cpu|memory$reset_color"
    procs --sortd cpu $1
}

alias ps\?="ps_search"

function nonsense() {
	genact -s 2 -m $(genact -l | tail +2 | shuf | sed 's/^[ \t]*//' | gum choose --height=20 --timeout=4s || echo "julia")
}

