#!/usr/bin/env bash
set -euo pipefail

config_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
repo_dir=$(dirname -- "$config_dir")
source_dir="$repo_dir/deps/vim-zellij-navigator"
upstream_commit=6d2a3e0c1d6c64daf1ed19e9ea0849259b71f180
patch_file="$config_dir/vim-zellij-navigator.patch"

if [[ ! -d "$source_dir/.git" ]]; then
    mkdir -p "$repo_dir/deps"
    git clone --branch 0.3.0 --depth 1 \
        https://github.com/hiasr/vim-zellij-navigator.git "$source_dir"
fi

if [[ $(git -C "$source_dir" rev-parse HEAD) != "$upstream_commit" ]]; then
    echo "Navigator checkout must be at upstream commit $upstream_commit" >&2
    exit 1
fi

# Repeated installs reuse the patched checkout without resetting local edits.
if git -C "$source_dir" apply --check "$patch_file" 2>/dev/null; then
    git -C "$source_dir" apply "$patch_file"
elif ! git -C "$source_dir" apply --reverse --check "$patch_file" 2>/dev/null; then
    echo "Navigator patch conflicts with local changes in $source_dir" >&2
    exit 1
fi

rustup target add wasm32-wasip1
(
    cd "$source_dir"
    cargo build --locked --release --target wasm32-wasip1
)
mkdir -p "$config_dir/plugins"
install -m 644 \
    "$source_dir/target/wasm32-wasip1/release/vim-zellij-navigator.wasm" \
    "$config_dir/plugins/vim-zellij-navigator.wasm"
echo "Installed patched navigator at $config_dir/plugins/vim-zellij-navigator.wasm"
