#!/usr/bin/env zsh

set -e

if [ "$(uname)" != "Darwin" ]; then
    echo "Not in darwin. Nothing to do."
    exit 0
fi

# Install homebrew: https://brew.sh/
if ! command -v brew > /dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo
fi

brew bundle

