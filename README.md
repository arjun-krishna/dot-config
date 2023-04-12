# dot-config
personal configuration files

## Dependencies

- install zsh
```bash
sudo apt install zsh
```

- install Oh-My-Zsh [https://ohmyz.sh/](link)
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- install zsh-plugins
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

- install nvim. [https://github.com/neovim/neovim/wiki/Building-Neovim](build-from-src)

- install rust and cargo
```bash
curl https://sh.rustup.rs -sSf | sh
```

- install alacritty from cargo. [https://github.com/alacritty/alacritty/blob/master/INSTALL.md](installation-instructions)

- install tmux from [release-tarball](https://github.com/tmux/tmux) [>3.1 required]. Dependencies:
```bash
sudo apt install libncurses-dev libevent-dev
```

- install [NodeJs](https://nodejs.dev/en/download/)
```bash
sudo cp bin/node /usr/bin/
```

## Terminal Utilities

- [ripgrep](https://github.com/BurntSushi/ripgrep): used by telescope in nvim to ignore files in .gitignore etc.,
```bash
sudo apt install ripgrep
```

- xterm
```bash
sudo apt install xterm
```

- NerdFonts
```bash
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh FiraCode
```
