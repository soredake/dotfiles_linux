#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

# create initial folders
[[ ! -d "$XDG_DATA_HOME/atom" ]] && mkdir -p "$XDG_DATA_HOME/atom"
[[ ! -d "$XDG_CONFIG_HOME/kitty" ]] && mkdir -p "$XDG_CONFIG_HOME/kitty"

# remove if non-link
[[ ! -L "$HOME/.pam_environment" ]] && rm "$HOME/.pam_environment"

for d in $(echo */);
do
  stow $1 -v 2 -d "$SD" -t "$HOME" "$d"
done
