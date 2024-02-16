#!/bin/bash

# To use if there are any modifications that dont need to be checked in
if [ -f ~/.zshrc.local.sh ]; then
    source ~/.zshrc.local.sh
fi

alias sanitize="~/.dotfiles/source/sanitize.mjs"
if [[ $(pwd) == *x2/seller* ]]; then
    alias sanitize="/Users/rushi/Sites/work/xola/x2/seller/git_ignore/zx_sanitize.mjs"
fi
