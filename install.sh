#!/bin/bash

# Basic installation script to quickly setup dotfiles

# If OSX
if [[ "$OSTYPE" =~ ^darwin ]]; then
    echo "Looks like you're on OS X, here are a few notes:"
    echo "* You need to be an administrator (for sudo)."
    echo "* You need to have installed XCode Command Line Tools (https://developer.apple.com/downloads/index.action?=command%20line%20tools), which are available as a separate, optional (and _much smaller_) download from XCode"
    read -n 1 -s -p 'Press Y to go install '
    echo ''
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        echo "Beginning install..."
        bash -c "$(curl -fsSL https://raw.github.com/rushi/dotfiles/master/bin/dotfiles)" && `$SHELL` && source ~/.zshrc
    else
        echo "Aborted"
        exit 1
    fi
elif [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]]; then
    echo "Looks like you're on Ubuntu, here are a few notes:"
    echo "* You need to be an administrator (for sudo)."
    echo "* If APT hasn't been updated or upgraded recently, it will probably be a few minutes before you see anything."
    read -n 1 -s -p 'Press Y to go install '
    echo ''
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        echo "Beginning install..."
        sudo apt-get -qq update && sudo apt-get -qq upgrade && sudo apt-get -qq install curl && echo && bash -c "$(curl -fsSL https://raw.github.com/rushi/dotfiles/master/bin/dotfiles)" && `$SHELL` && source ~/.zshrc
    else
        echo "Aborted"
        exit 1
    fi
else
    echo "Erm... I can't run on this operating system. This is for OSX and Ubuntu Only"
    exit 1
fi
