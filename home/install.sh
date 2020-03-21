#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

# create initial folders
[[ ! -d "$HOME/.config/VSCodium" ]] && mkdir -p "$HOME/.config/VSCodium"
[[ ! -d "$HOME/.config/fish" ]] && mkdir -p "$HOME/.config/fish"
[[ ! -d "$HOME/.config/git" ]] && mkdir -p "$HOME/.config/git"
[[ ! -d "$HOME/.config/kitty" ]] && mkdir -p "$HOME/.config/kitty"
[[ ! -d "$HOME/.config/mpv" ]] && mkdir -p "$HOME/.config/mpv"
[[ ! -d "$HOME/.config/systemd/user" ]] && mkdir -p "$HOME/.config/systemd/user"

for d in $(echo */);
do
  stow $1 -v 2 -d "$SD" -t "$HOME" "$d"
done