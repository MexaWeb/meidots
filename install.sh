#!/usr/bin/env bash
# meow




echo "hello welcome to meidots!!1!"
read -s -p "press enter to install meidots..."

echo

sudo -v


set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

command -v jq >/dev/null || {
    echo "error: jq is required"
    exit 1
}

while IFS=$'\t' read -r source destination; do
    destination="${destination/#\~/$HOME}"
    source="$SCRIPT_DIR/configs/$source"

    if [[ ! -e "$source" ]]; then
        echo "warning: source $source does not exist, skipping"
        continue
    fi

    echo "linking $source -> $destination"
    mkdir -p "$(dirname "$destination")"
    rm -rf "$destination"
    ln -s "$source" "$destination"

done < <(
    jq -r 'to_entries[] | [.key, .value] | @tsv' directories.json
)

sudo pacman -Syu --needed --noconfirm --disable-download-timeout - < packages

echo "done."