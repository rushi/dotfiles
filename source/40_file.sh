#!/bin/bash

# Files will be created with these permissions:
# files 644 -rw-r--r-- (666 minus 022)
# dirs  755 drwxr-xr-x (777 minus 022)
umask 022

# Comment out `eza` in place of ls to test it out
# Always use color output for `ls`
# alias ls="command ls --color=auto"
# export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Directory listing
# alias ll='ls -al'
# alias tree="tree -C"

# eza
alias l="eza -lh --octal-permissions"
alias ls="eza"
alias ll="eza -lh --octal-permissions"
alias la="eza -alg --octal-permissions"
alias tree="eza --tree"
alias lslrt="eza -lrh --sort oldest --octal-permissions "
alias lsrt="eza -lrh --sort oldest --octal-permissions "

# Easier navigation: .., ..., -
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'
alias cd..="cd .."

# File size
#alias df="df -h"
alias df="duf"

# Recursively delete `.DS_Store` files
alias dsstoredel="find . -name '*.DS_Store' -type f -ls -delete"

# Create a new directory and enter it
function mdcd() {
  mkdir -p "$@" && cd "$@" || exit
}

# Show markdown files in CLI
alias md="glow"

alias bak="backup"
function backup() {
  if [[ $2 == "mv" ]]; then
    echo "Move/Renaming to ${1}.bak"
    mv "$1" "$1.bak"
  else
      echo "Copying to ${1}.bak (use 'mv' in \$2 to move)"
    cp -r "$1" "$1.bak"
  fi
}

alias cls="clear"
alias csv="csvlook" # brew install csvkit
alias sync="rsync -ravz --progress -h"

export personal="$HOME/Sites/personal"
export p="$personal" # personal is just so long to type
export work="$HOME/Sites/work/xola"
export x2="$HOME/Sites/work/xola/x2"

if [[ -z $GIT_PREFIX ]]; then
  if [[ $SHELL == "/bin/zsh" ]]; then
    eval "$(zoxide init zsh)"
  fi
fi
