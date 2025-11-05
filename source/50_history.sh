#!/bin/bash

# History settings

# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
export HISTCONTROL="ignorespace:erasedups"

# Give history timestamps.
export HISTTIMEFORMAT="[%F %T] "

# Lots o' history.
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

if [[ -z $GIT_PREFIX ]]; then
    setopt extended_history       # record timestamp of command in HISTFILE
    setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
    setopt hist_ignore_dups       # ignore duplicated commands history list
    setopt hist_ignore_space      # ignore commands that start with space
    setopt hist_verify            # show command with history expansion to user before running it
fi

alias hgrep="history | grep -i"
