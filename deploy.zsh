#!/usr/bin/env zsh

set -e

DOTPATH="$HOME/dotfiles"

if [ ! -e "$DOTPATH" ]; then
    echo "Error: Directory $DOTPATH does not exist."
    exit 1
fi

cd "$DOTPATH" || exit 1

mkdir -p "$XDG_CONFIG_HOME/{gitui,nvim/lua,zsh}"

ln -fvns $DOTPATH/.config/gitui/key_bindings.ron $HOME/.config/gitui/key_bindings.ron

ln -fvns $DOTPATH/.config/nvim/init.lua $HOME/.config/nvim/init.lua
ln -fvns $DOTPATH/.config/nvim/lua/colors.lua $HOME/.config/nvim/lua/colors.lua
ln -fvns $DOTPATH/.config/nvim/lua/keymaps.lua $HOME/.config/nvim/lua/keymaps.lua
ln -fvns $DOTPATH/.config/nvim/lua/plugins.lua $HOME/.config/nvim/lua/plugins.lua

ln -fvns $DOTPATH/.config/zsh/.fzf.zsh $HOME/.config/zsh/.fzf.zsh
ln -fvns $DOTPATH/.config/zsh/.zimrc.zsh $HOME/.config/zsh/.zimrc.zsh
ln -fvns $DOTPATH/.config/zsh/.zshrc.zsh $HOME/.config/zsh/.zshrc.zsh

