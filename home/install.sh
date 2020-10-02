#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

for d in $(echo */);
do
  stow --no-folding $1 -v 2 -d "$SD" -t "$HOME" "$d"
done
