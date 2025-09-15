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

function git_tag() {
    local repo="$1"
    if [ -z "$repo" ]; then
        echo "Usage: git_tag <repository>"
        return 1
    fi
    VERSION=$(git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' https://github.com/$repo \
      | awk '{print $2}' \
      | grep -E 'refs/tags/v?[0-9]+\.[0-9]+\.[0-9]+$' \
      | sed -E 's|refs/tags/v?||' \
      | tail -n1)
    echo "(info) git:$repo latest version -> v$VERSION"
    return 0
}

function check_cache() {
    local repo="$1"
    local version="$2"
    local cached_version=$(grep "^git:$repo:" $CACHE_VERSIONS | awk -F: '{print $3}')
    if [ -n "$cached_version" ] && [ "$cached_version" == "$version" ]; then
        echo "(info) git:$repo is already up-to-date (v$version)."
        return 0
    else
        sed -i "/^git:$repo:/d" "$CACHE_VERSIONS"
        echo "(info) added git:$repo:$version to cache."
        echo "git:$repo:$version" >> $CACHE_VERSIONS
        return 1
    fi
}

function dl_git() {
    local repo="$1"
    local file="$2"
    if [ -z "$repo" ] || [ -z "$file" ]; then
        echo "Usage: dl_git <repository> <file>"
        return 1
    fi
    DL_PATH=""
    git_tag $repo
    local version=$VERSION
    check_cache $repo $version
    if [ $? -ne 0 ]; then
        echo "(info) updating git:$repo to v$version"
        local dl_url="https://github.com/$repo/releases/download/v$version/$file"
        DL_PATH="/tmp/$file"
        curl -L $dl_url -o $DL_PATH
        if [ $? -ne 0 ]; then
            echo "(error) failed to download $dl_url"
            unset DL_PATH
            return 1
        fi
    fi
    return 0
}

function install_dmg() {
    local dmg_path="$1"
    local dmg="$(basename "$dmg_path" .dmg)"
    echo "(info) mounting $dmg"
    hdiutil mount $dmg_path -noverify -nobrowse -noautoopen
    # Find the application within the mounted volume and copy it to Applications
    local app_path=$(find /Volumes/ -name "*.app" -maxdepth 2 | head -n 1)
    if [[ -n "$app_path" ]]; then
        local app_name=$(basename "$app_path" .app)
        echo "(info) copying $app_name to /Applications/"
        sudo rsync -av "$app_path" /Applications/
        echo "(info) changing permissions on $app_name"
        sudo chown -R root:wheel "/Applications/$app_name.app"
        sudo chmod -R 755 "/Applications/$app_name.app"
    else
        echo "(warning) no .app found in the DMG, manual installation may be required."
    fi
    echo "(info) unmounting $dmg"
    hdiutil unmount /Volumes/"$dmg"*
    echo "(info) clean up dmg file"
    rm -rf $dmg_path
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
    
    # alacritty
    REPO="alacritty/alacritty"
    git_tag $REPO
    check_cache $REPO $VERSION
    if [ $? -ne 0 ]; then
        echo "(info) updating git:$REPO to v$VERSION"
        DL_URL="https://github.com/$REPO/releases/download/v$VERSION/Alacritty-v$VERSION.dmg"
        DMG_PATH="/tmp/Alacritty.dmg"
        curl -Lo $DMG_PATH $DL_URL
        if [ $? -ne 0 ]; then
            echo "(error) failed to download $DL_URL"
            exit 1
        else
            install_dmg $DMG_PATH
            # update_link alacritty /Applications/Alacritty.app/Contents/MacOS/alacritty $HOME/.local/bin/alacritty
        fi
    fi
fi
