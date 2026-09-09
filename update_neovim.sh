#!/bin/bash

set -euo pipefail

if [[ "${OSTYPE:-}" != darwin* ]]; then
    echo "(error) update_neovim.sh only supports macOS"
    exit 1
fi

if [[ "$(uname -m)" != "arm64" ]]; then
    echo "(error) this installer expects an Apple Silicon (arm64) Mac"
    exit 1
fi

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
DEPS_DIR="$SCRIPT_DIR/deps"
NVIM_DIR="$DEPS_DIR/nvim"
NVIM_LINK="$HOME/.local/bin/nvim"
REPO="neovim/neovim"
ARCHIVE="nvim-macos-arm64.tar.gz"

LATEST_VERSION=$(
    git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' "https://github.com/$REPO" \
        | awk '{print $2}' \
        | grep -E 'refs/tags/v[0-9]+\.[0-9]+\.[0-9]+$' \
        | sed -E 's|refs/tags/v||' \
        | tail -n 1
)

if [[ -z "$LATEST_VERSION" ]]; then
    echo "(error) could not determine the latest Neovim version"
    exit 1
fi

CURRENT_VERSION=""
if [[ -x "$NVIM_DIR/bin/nvim" ]]; then
    CURRENT_VERSION=$("$NVIM_DIR/bin/nvim" --version | awk 'NR == 1 { sub(/^NVIM v/, ""); print }')
fi

if [[ "$CURRENT_VERSION" == "$LATEST_VERSION" && "${1:-}" != "--force" ]]; then
    echo "(info) Neovim is already up-to-date (v$LATEST_VERSION)"
    exit 0
fi

DOWNLOAD_PATH=$(mktemp "${TMPDIR:-/tmp}/nvim-macos-arm64.XXXXXX.tar.gz")
EXTRACT_DIR=$(mktemp -d "${TMPDIR:-/tmp}/nvim-update.XXXXXX")

cleanup() {
    rm -f "$DOWNLOAD_PATH"
    rm -rf "$EXTRACT_DIR"
}
trap cleanup EXIT

DOWNLOAD_URL="https://github.com/$REPO/releases/download/v$LATEST_VERSION/$ARCHIVE"
echo "(info) updating Neovim ${CURRENT_VERSION:-not installed} -> $LATEST_VERSION"
curl --fail --location "$DOWNLOAD_URL" --output "$DOWNLOAD_PATH"
xattr -c "$DOWNLOAD_PATH"
tar xzf "$DOWNLOAD_PATH" -C "$EXTRACT_DIR"

mkdir -p "$DEPS_DIR" "$(dirname "$NVIM_LINK")"
rm -rf "$NVIM_DIR"
mv "$EXTRACT_DIR/nvim-macos-arm64" "$NVIM_DIR"
ln -sfn "$NVIM_DIR/bin/nvim" "$NVIM_LINK"

echo "(info) installed $("$NVIM_LINK" --version | head -n 1)"
