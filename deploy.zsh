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

mkdir -p "$HOME/.config/nvim"
ln -fvns "$DOTPATH/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
ln -fvns "$DOTPATH/.config/nvim/lua" "$HOME/.config/nvim/lua"

mkdir -p "$HOME/.config/zsh"
ln -fvns "$DOTPATH/.zshenv" "$HOME/.zshenv"
ln -fvns "$DOTPATH/.config/zsh/.fzf.zsh" "$HOME/.config/zsh/.fzf.zsh"
ln -fvns "$DOTPATH/.config/zsh/.zimrc" "$HOME/.config/zsh/.zimrc"
ln -fvns "$DOTPATH/.config/zsh/.zshrc" "$HOME/.config/zsh/.zshrc"

mkdir -p "$HOME/.config/wezterm"
ln -fvns "$DOTPATH/.config/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"

ln -fvns "$DOTPATH/.gitconfig" "$HOME/.gitconfig"
ln -fvns "$DOTPATH/.gitignore" "$HOME/.gitignore"

mkdir -p "$HOME/.config/tmux"
ln -fvns "$DOTPATH/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
