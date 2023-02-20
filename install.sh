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

cmp -s .zshrc $HOME/.zshrc
if [ ! $? -eq 0 ]; then
	echo "updating .zshrc"
	cp .zshrc $HOME/.zshrc
else
	echo ".zshrc already up-to-date."
fi
cmp -s .p10k.zsh $HOME/.p10k.zsh
if [ ! $? -eq 0 ]; then
	echo "updating p10k configuration"
	cp .p10k.zsh $HOME/.p10k.zsh
else
	echo "p10k already up-to-date."
fi
