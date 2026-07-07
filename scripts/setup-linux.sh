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
sudo apt install texlive-science zathura -y
sudo apt install xterm xclip -y
echo

# libfuse (appimage)

echo "■ done"
