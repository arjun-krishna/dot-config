#!/usr/bin/sh
echo "installing .config ..."

if [ ! -d "$HOME/.config/nvim" ]; then
	echo "creating softlink: nvim"
	ln -s $(pwd)/nvim $HOME/.config/nvim 
fi

if [ ! -d "$HOME/.config/alacritty" ]; then
	echo "creating softlink: alacritty"
	ln -s $(pwd)/alacritty $HOME/.config/alacritty 
fi

echo "copying .zshrc"
cp .zshrc $HOME/.zshrc
