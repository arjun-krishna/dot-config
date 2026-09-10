#!/bin/bash
echo "[.config] installing .config ..."

link_config() {
    local app="$1"
    local src="$2"
    local target="$3"

    if [ -z "$app" ] || [ -z "$src" ] || [ -z "$target" ]; then
        echo "Usage: link_config <app> <src> <target>"
        return 1
    fi

    if [ -L "$target" ]; then
        # It's a symlink; check where it points
        local current_src
        current_src=$(readlink "$target")
        if [ "$current_src" != "$src" ]; then
		echo "[$app] symlink ($target) exists but points to $current_src. Overriding..."
            rm "$target"
            ln -s "$src" "$target"
        else
            echo "[$app] symlink is already set"
        fi
    elif [ -e "$target" ]; then
        # Exists but is not a symlink
	echo "[$app] [ERROR] $target exists but is not a symlink. Please remove it or backup manually."
        return 1
    else
        # Doesn't exist; create symlink
        ln -s "$src" "$target"
        echo "[$app] created symlink"
    fi
}
update_config() {
    local app="$1"
    local src="$2"
    local target="$3"

    if [ -z "$app" ] || [ -z "$src" ] || [ -z "$target" ]; then
        echo "Usage: update_config <app> <src> <target>"
        return 1
    fi
    cmp -s "$src" "$target"
    if [ ! $? -eq 0 ]; then
	    echo "[$app] updating $target"
	    cp $src $target
    else
	    echo "[$app] already up-to-date."
    fi
}

link_config nvim $(pwd)/nvim $HOME/.config/nvim
if [[ "$OSTYPE" == "darwin"* ]]; then
    mkdir -p "$HOME/Library/Application Support/sioyek"
    link_config sioyek $(pwd)/sioyek/keys_user.config "$HOME/Library/Application Support/sioyek/keys_user.config"
else
    link_config sioyek $(pwd)/sioyek $HOME/.config/sioyek
fi
link_config zellij $(pwd)/zellij $HOME/.config/zellij

update_config zshrc .zshrc $HOME/.zshrc
link_config zshrc_custom $(pwd)/.zshrc.custom $HOME/.zshrc.custom
update_config zprofile .zprofile $HOME/.zprofile
update_config p10k .p10k.zsh $HOME/.p10k.zsh

update_config bashrc .bashrc $HOME/.bashrc
update_config vimrc vim/.vimrc $HOME/.vimrc
link_config vim $(pwd)/vim/.vim $HOME/.vim

link_config ghostty $(pwd)/ghostty $HOME/.config/ghostty
