#!/bin/bash
## Assumed Dependencies
# - git
# - awk

## SETUP DIRECTORIES
DEPS_DIR=$(pwd)/deps
CACHE_VERSIONS=$DEPS_DIR/.versions

if [ "$1" == "--force" ]; then
    echo "(info) Forcing update of all dependencies."
    rm -f $CACHE_VERSIONS
fi

if [ ! -d $DEPS_DIR ]; then
    mkdir -p $DEPS_DIR
fi
if [ ! -e $CACHE_VERSIONS ]; then
    touch $CACHE_VERSIONS
fi

function dl_git() {
    local repo="$1"
    local file="$2"
    if [ -z "$repo" ] || [ -z "$file" ]; then
        echo "Usage: dl_git <repository> <file>"
        return 1
    fi
    DL_PATH=""
    version=$(git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' https://github.com/$repo | tail -n1 | awk '{ if (match($2, /[0-9]+(\.[0-9]+)*/)) print substr($2, RSTART, RLENGTH) }')
    echo "(info) git:$repo:$version"
    cached_version=$(grep "^git:$repo:" $CACHE_VERSIONS | awk -F: '{print $3}')
    if [ -n "$cached_version" ] && [ "$cached_version" == "$version" ]; then
        echo "(info) git:$repo is already up-to-date."
        return 0
    else
        echo "(info) updating git:$repo to version $version"
        echo "git:$repo:$version" >> $CACHE_VERSIONS
        local dl_url="https://github.com/$repo/releases/download/v$version/$file"
        DL_PATH="/tmp/$file"
        curl -L $dl_url -o $DL_PATH
        if [ $? -ne 0 ]; then
            echo "(error) failed to download $dl_url"
            unset DL_PATH
            return 1
        fi
    fi
}

function update_link() {
    local app="$1"
    local src="$2"
    local target="$3"
    if [ -z "$app" ] || [ -z "$src" ] || [ -z "$target" ]; then
        echo "Usage: update_link <app> <src> <target>"
        return 1
    fi
    if [ -L "$target" ]; then
        # It's a symlink; check where it points
        local current_src
        current_src=$(readlink "$target")
        if [ "$current_src" != "$src" ]; then
            rm "$target"
        fi
    elif [ -e "$target" ]; then
        # Exists but is not a symlink
        rm "$target"
    fi
    if [ ! -e "$target" ]; then
        ln -s "$src" "$target"
        echo "[$app] created symlink"
    else
        echo "[$app] symlink is already set"
    fi
}

# MACOS setup
if [[ "$OSTYPE" == "darwin"* ]]; then
    # neovim install
    dl_git "neovim/neovim" "nvim-macos-arm64.tar.gz"
    if [ $? -ne 0 ]; then
        exit 1
    fi
    if [ -n "$DL_PATH" ]; then
        echo "(info) extracted $DL_PATH to $DEPS_DIR"
        xattr -c $DL_PATH # avoid "unknown developer" macOS warning
        if [ -d $DEPS_DIR/nvim ]; then
            rm -rf $DEPS_DIR/nvim
        fi
        tar xzf $DL_PATH -C $DEPS_DIR
        mv $DEPS_DIR/nvim-macos-arm64 $DEPS_DIR/nvim
        rm -f $DL_PATH
        update_link nvim $DEPS_DIR/nvim/bin/nvim $HOME/.local/bin/nvim
    fi

    HOMEBREW_PKGS=(ripgrep fzf font-fira-code-nerd-font)
    for pkg in "${HOMEBREW_PKGS[@]}"; do
        if [ ! brew list --versions $pkg &> /dev/null ] || [ ! brew list --versions --cask $pkg &> /dev/null ]; then
            echo "(info) Installing $pkg via Homebrew"
            brew install $pkg
        else
            echo "(info) $pkg is already installed"
        fi
    done
fi
