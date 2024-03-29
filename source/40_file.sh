# Files will be created with these permissions:
# files 644 -rw-r--r-- (666 minus 022)
# dirs  755 drwxr-xr-x (777 minus 022)
umask 022

# Comment out `exa` in place of ls to test it out
# Always use color output for `ls`
# alias ls="command ls --color=auto"
# export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Directory listing
# alias ll='ls -al'
# alias tree="tree -C"

# exa
alias l="exa -lh --octal-permissions"
alias ls="exa"
alias ll="exa -lh --octal-permissions"
alias la="exa -alg --octal-permissions"
alias tree="exa --tree"
alias lslrt="exa -lrh --sort oldest --octal-permissions "
alias lsrt="exa -lrh --sort oldest --octal-permissions "

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
  mkdir -p "$@" && cd "$@"
}

# Show markdown files in CLI
alias md="glow"

alias bak="backup"
function backup() {
  echo "Renaming to ${1}.bak"
  cp -r "$1" "$1.bak"
}

alias cls="clear"
# Open file in textmate and add it to the recent files menu
alias mate="mate -r"
# Install `csvlook` for this (pip install)
alias csv="csvlook"
alias sync="rsync -ravz --progress -h"

export personal="$HOME/Sites/personal"
export p="$personal" # personal is just so long to type
export work="$HOME/Sites/work/xola"
export x2="$HOME/Sites/work/xola/x2"

## ZOXIDE (z command) https://github.com/ajeetdsouza/zoxide#installation
if [[ $SHELL == "/bin/zsh" ]]; then
  eval "$(zoxide init zsh)"
fi
