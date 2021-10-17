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
else
    echo "Erm... I can't run on this operating system. This is for OSX only"
    exit 1
fi
