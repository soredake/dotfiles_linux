#!/bin/bash
SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1
dconf dump /org/gnome/terminal/ > "$SD/gnome.conf"
