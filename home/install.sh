#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

# create initial folders
[[ ! -d "$XDG_CONFIG_HOME/VSCodium" ]] && mkdir -p "$XDG_CONFIG_HOME/VSCodium"
[[ ! -d "$XDG_CONFIG_HOME/git" ]] && mkdir -p "$XDG_CONFIG_HOME/git"
[[ ! -d "$XDG_CONFIG_HOME/mpv" ]] && mkdir -p "$XDG_CONFIG_HOME/mpv"
[[ ! -d "$XDG_CONFIG_HOME/kitty" ]] && mkdir -p "$XDG_CONFIG_HOME/kitty"
[[ ! -d "$XDG_CONFIG_HOME/systemd/user" ]] && mkdir -p "$XDG_CONFIG_HOME/systemd/user"

# remove if non-link
[[ ! -L "$HOME/.pam_environment" ]] && rm "$HOME/.pam_environment"

for d in $(echo */);
do
  stow $1 -v 2 -d "$SD" -t "$HOME" "$d"
done