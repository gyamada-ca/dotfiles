#!/usr/bin/env zsh

set -e

DOTPATH="$HOME/dotfiles"

if [ ! -d "$DOTPATH" ]; then
    git clone https://github.com/gactocat/dotfiles.git "$DOTPATH"
else
    echo "$DOTPATH already downloaded. Updating..."
    cd "$DOTPATH"
    git stash
    git checkout main
    git pull origin main
    echo
fi

cd "$DOTPATH"

deploy.zsh
echo

brew.zsh
echo

