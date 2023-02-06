#!/usr/bin/sh
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

if [ ! -d "$HOME/.config/tmux" ]; then
	echo "tmux: creating softlink"
	ln -s $(pwd)/tmux $HOME/.config/tmux 
else
	echo "tmux: already linked"
fi

echo "copying .zshrc"
cp .zshrc $HOME/.zshrc
