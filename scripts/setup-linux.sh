#!/bin/bash
set -e

bold=$(tput bold)
normal=$(tput sgr0)

sudo apt update && sudo apt upgrade

print_header() {
    local header="$1"
    echo "--------------------------------------------------------------------------------"
    echo "${bold}▶ $header${normal}"
    echo "--------------------------------------------------------------------------------"
}

print_header "git"
if command -v git &> /dev/null; then
    echo "✓ already installed at $(which git)"
    git --version
else
    echo "∅ not found ... installing ..."
    sudo apt install git -y
fi
echo

print_header "curl"
if command -v curl &> /dev/null; then
    echo "✓ already installed at $(which curl)"
    curl --version
else
    echo "∅ not found ... installing ..."
    sudo apt install curl -y
fi
echo

print_header "build-essential"
if command -v gcc g++ make &> /dev/null; then
    echo "✓ already installed"
    echo "→ gcc ($(which gcc))"
    gcc --version

    echo "→ g++ ($(which g++))"
    g++ --version

    echo "→ make ($(which make))"
    make --version
else
    echo "∅ not found ... installing ..."
    sudo apt install build-essential -y
fi
echo

print_header "cmake"
if command -v cmake &> /dev/null; then
    echo "✓ already installed at $(which cmake)"
    cmake --version
else
    echo "∅ not found ... installing ..."
    sudo apt install cmake -y
fi
echo

print_header "keyd"
if command -v keyd &> /dev/null; then
    echo "✓ already installed at $(which keyd)"
    keyd --version
else
    echo "∅ not found ... installing ..."
    # Repo: https://github.com/rvaiya/keyd
    mkdir -p ../deps
    cd ../deps/ && \
    git clone https://github.com/rvaiya/keyd && \
    cd keyd && \
    make && sudo make install && \
    sudo systemctl enable --now keyd
fi
# configure keyd
echo "○ configuring ..."
if [ ! -f "/etc/keyd/default.conf" ]; then
    sudo mkdir -p /etc/keyd && sudo touch /etc/keyd/default.conf
fi
if ! grep -q "# 》auto-setup" /etc/keyd/default.conf > /dev/null 2>&1; then
    cat ~/dot-config/scripts/config/keyd/default.conf | sudo tee -a /etc/keyd/default.conf > /dev/null
    sudo keyd reload
    echo "✓ configured"
else
    echo "✓ already configured"
fi
echo

# install Rust
print_header "rust"
if command -v rustc cargo &> /dev/null; then
    echo "✓ already installed"
    cargo --version
    rustc --version
else
    curl https://sh.rustup.rs -sSf | sh
fi
## source variables
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
echo

print_header "term-utils"
if ! command -v ripgrep; then
    # [ripgrep](https://github.com/BurntSushi/ripgrep)
    # [fd](https://github.com/sharkdp/fd)
    cargo install fd-find ripgrep
    cargo install --locked "tree-sitter-cli@0.25.10"
    # [fzf](https://github.com/junegunn/fzf)
    # [htop](https://htop.dev/)
    sudo apt install fzf htop -y
    if command -v nvidia-smi &> /dev/null; then
        sudo apt install nvtop -y
    fi
fi
echo

print_header "editor"
cargo install --locked "tree-sitter-cli@0.25.10"
sudo apt install -y \
    texlive-science \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-science \recommended
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-extra-utils \
    latexmk \
    sioyek
sudo apt install xterm xclip -y
echo

print_header "shell"
sudo apt install zsh -y
sudo chsh -s "$(command -v zsh)" # make zsh default shell

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "∅ Oh My Zsh not found ... installing ..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "✓ Oh My Zsh already installed"
fi

zsh_custom_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$zsh_custom_dir/plugins" "$zsh_custom_dir/themes"

if [ ! -d "$zsh_custom_dir/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$zsh_custom_dir/plugins/zsh-syntax-highlighting"
else
    echo "✓ zsh-syntax-highlighting already installed"
fi

if [ ! -d "$zsh_custom_dir/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$zsh_custom_dir/plugins/zsh-autosuggestions"
else
    echo "✓ zsh-autosuggestions already installed"
fi

if [ ! -d "$zsh_custom_dir/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "$zsh_custom_dir/themes/powerlevel10k"
else
    echo "✓ powerlevel10k already installed"
fi
echo
if ! command -v zellij; then
    cargo install --locked zellij
fi
bash "$(dirname -- "${BASH_SOURCE[0]}")/../zellij/install.sh"

print_header "ghostty launcher"
applications_dir="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
ghostty_desktop="$applications_dir/com.mitchellh.ghostty.desktop"
mkdir -p "$applications_dir"
cat > "$ghostty_desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Ghostty
Comment=Fast, feature-rich terminal emulator
Exec=$HOME/.local/bin/ghostty
Icon=utilities-terminal
Terminal=false
Categories=System;TerminalEmulator;
Keywords=terminal;shell;prompt;command;commandline;
StartupNotify=true
StartupWMClass=com.mitchellh.ghostty
EOF
chmod 644 "$ghostty_desktop"

if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$applications_dir"
fi
echo "✓ application launcher installed at $ghostty_desktop"

print_header "chafa"
if [ ! -d deps/chafa ]; then
    git clone https://github.com/hpjansson/chafa.git deps/chafa
else
    cd deps/chafa && git pull && cd ../..
fi
sudo apt install -y \
    autoconf \
    automake \
    libtool \
    libfreetype6-dev \
    libavif-dev \
    libdeflate-dev \
    libheif-dev \
    libjpeg-dev \
    libjxl-dev \
    librsvg2-dev \
    libtiff5-dev \
    libwebp-dev
cd deps/chafa && ./autogen.sh && make && sudo make install && sudo ldconfig && cd ../..

echo "■ done"
