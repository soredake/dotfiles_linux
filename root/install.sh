#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit; pwd)";
cd "$SD"

for d in $(echo */);
do
  sudo stow $1 -v -d "$SD" -t / "$d"
done
