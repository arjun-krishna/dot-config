# dot-config
personal configuration files

## Submodule initialize
Dependencies: tmux-plugins
```bash
git submodule update --init --recursive
```

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
```bash
cd ~
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
sudo ln -s ~/nvim.appimage /usr/bin/nvim
```

- install rust and cargo
```bash
curl https://sh.rustup.rs -sSf | sh
```

- install alacritty from cargo. [https://github.com/alacritty/alacritty/blob/master/INSTALL.md](installation-instructions)

- install tmux from [release-tarball](https://github.com/tmux/tmux) [>3.1 required]. Dependencies:
```bash
sudo apt install libncurses-dev libevent-dev
```

## Terminal Utilities

- [ripgrep](https://github.com/BurntSushi/ripgrep): used by telescope in nvim to ignore files in .gitignore etc.,
```bash
sudo apt install ripgrep
```

- fd [fd](https://github.com/sharkdp/fd)
```bash
apt install fd
brew install fd
```

- fzf
```bash
brew install fzf
```

- xterm
```bash
sudo apt install xterm
```

- install xclip
```bash
sudo apt install xclip
```

- NerdFonts
```bash
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh FiraCode
# (OSX) brew
brew install font-fira-code-nerd-font
```

## Rust

[docs](https://doc.rust-lang.org/cargo/getting-started/installation.html)
```bash
curl https://sh.rustup.rs -sSf | sh
```

## NVM

-- Need this for CoPilot and other fun LSP stuff :)

[nvm](https://github.com/nvm-sh/nvm)
node and npm
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
```

```bash
nvm install 16
# nvm use 16
```

## Using Mamba

Follow mamba [installation guide](https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html)

- It uses the miniforge backend and can be used in sync with conda (have the same setup on the cluster)

# Utilities
- [nvtop](https://github.com/Syllo/nvtop)

# VSCode
> I sync my settings with github (so install vscode and have them sync up to be my preferred environment)
> Fonts I use powerlevel10k recommended Meslos NGF (follow installation [instructions](https://github.com/romkatv/powerlevel10k/blob/master/font.md))

## TreeSitter

```bash
npm install tree-sitter-cli -g
# cargo install --locked tree-sitter-cli (used in Mac)
```

# Latex

## TexLive

```bash
sudo apt install texlive-science
```

## Zathura

```bash
sudo apt install zathura
```

```
1. `brew install dbus` or "reinstall"
2. add export DBUS_SESSION_BUS_ADDRESS='unix:path='$DBUS_LAUNCHD_SESSION_BUS_SOCKET to .zshrc
3. Run brew services start dbus

Install Zathura
# unlink installed zathura and girara
brew unlink girara
brew unlink zathura

# install HEAD
brew install girara
brew uninstall zathura-pdf-poppler
brew uninstall zathura
brew install zathura --with-synctex
brew install zathura-pdf-poppler
mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib
```
