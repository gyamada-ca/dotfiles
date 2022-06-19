#!/usr/bin/env zsh

set -e

DOTPATH="$HOME/dotfiles"

if [ ! -e "$DOTPATH" ]; then
    echo "Error: Directory $DOTPATH does not exist."
    exit 1
fi

cd "$DOTPATH" || exit 1


mkdir -p "$HOME/.config/gitui"
ln -fvns "$DOTPATH/.config/gitui/key_bindings.ron" "$HOME/.config/gitui/key_bindings.ron"

mkdir -p "$HOME/.config/nvim/lua"
ln -fvns "$DOTPATH/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
ln -fvns "$DOTPATH/.config/nvim/lua/colors.lua" "$HOME/.config/nvim/lua/colors.lua"
ln -fvns "$DOTPATH/.config/nvim/lua/keymaps.lua" "$HOME/.config/nvim/lua/keymaps.lua"
ln -fvns "$DOTPATH/.config/nvim/lua/plugins.lua" "$HOME/.config/nvim/lua/plugins.lua"

mkdir -p "$HOME/.config/zsh"
ln -fvns "$DOTPATH/.zshenv" "$HOME/.zshenv"
ln -fvns "$DOTPATH/.config/zsh/.fzf.zsh" "$HOME/.config/zsh/.fzf.zsh"
ln -fvns "$DOTPATH/.config/zsh/.zimrc" "$HOME/.config/zsh/.zimrc"
ln -fvns "$DOTPATH/.config/zsh/.zshrc" "$HOME/.config/zsh/.zshrc"

