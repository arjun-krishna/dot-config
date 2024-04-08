#!/usr/bin/env bash
echo "installing .config ..."

if [ ! -d "$HOME/.config/nvim" ]; then
	echo "nvim: creating softlink"
	ln -s $(pwd)/nvim $HOME/.config/nvim 
else
	echo "nvim: already linked"
fi

if [ ! -d "$HOME/.config/alacritty" ]; then
	echo "alacritty: creating softlink"
    ln -s $(pwd)/alacritty $HOME/.config/alacritty 
else
	echo "alacritty: already linked"
fi

rm -f $(pwd)/alacritty/alacritty.toml
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "alacritty: osx"
    ln -s $(pwd)/alacritty/osx.toml $(pwd)/alacritty/alacritty.toml
else
    echo "alacritty: linux"
    ln -s $(pwd)/alacritty/linux.toml $(pwd)/alacritty/alacritty.toml
fi

if [ ! -d "$HOME/.config/tmux" ]; then
	echo "tmux: creating softlink"
	ln -s $(pwd)/tmux $HOME/.config/tmux 
else
	echo "tmux: already linked"
fi

if [ ! -d "$HOME/.zshrc.custom" ]; then
	echo "creating .zshrc.custom"
	ln -s $(pwd)/.zshrc.custom $HOME/.zshrc.custom
else
	echo ".zshrc.custom already exists."
fi
cmp -s .zshrc $HOME/.zshrc
if [ ! $? -eq 0 ]; then
	echo "updating .zshrc"
	cp .zshrc $HOME/.zshrc
else
	echo ".zshrc already up-to-date."
fi
cmp -s .zprofile $HOME/.zprofile
if [ ! $? -eq 0 ]; then
	echo "updating .zprofile"
	cp .zprofile $HOME/.zprofile
else
	echo ".zprofile already up-to-date."
fi
cmp -s .p10k.zsh $HOME/.p10k.zsh
if [ ! $? -eq 0 ]; then
	echo "updating p10k configuration"
	cp .p10k.zsh $HOME/.p10k.zsh
else
	echo "p10k already up-to-date."
fi

cmp -s vim/.vimrc $HOME/.vimrc
if [ ! $? -eq 0 ]; then
	echo "updating .vimrc"
	cp vim/.vimrc $HOME/.vimrc
else
	echo ".vimrc already up-to-date."
fi
if [ ! -d "$HOME/.vim" ]; then
	echo "vim: creating softlink"
	ln -s $(pwd)/vim/.vim $HOME/.vim
else
	echo "vim: already linked"
fi
