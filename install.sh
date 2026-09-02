#!/usr/bin/env bash
# meow
set -euo pipefail




echo "hello welcome to meidots!!1!"

read -r -p "this will replace existing configs. backup them? [y/N] " answer
answer="${answer,,}"

case "$answer" in
    y|yes)
        answer="y"
        ;;
    n|no)
        answer="n"
        ;;
esac


if [[ "$answer" == "y" ]]; then
    echo "backing up existing configs to ~/meidots/backup"
    mkdir -p "./backup"
    while IFS=$'\t' read -r source destination; do
        destination="${destination/#\~/$HOME}"
        if [[ -e "$destination" ]]; then
            echo "backing up $destination"
            cp -r "$destination" "./backup/"
        fi
    done < <(
        jq -r 'to_entries[] | [.key, .value] | @tsv' directories.json
    )
fi



echo
read -s -p "press enter to install meidots..."
echo

sudo -v



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