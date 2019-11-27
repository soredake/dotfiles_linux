#!/bin/bash

packages=(
  advanced-open-file
  atom-beautify
  anseki.vscode-color
  EditorConfig.EditorConfig
  file-icons.file-icons
  ulthes.theme-firewatch
  mads-hartmann.bash-ide-vscode
  timonwong.shellcheck
  #git-time-machine
  mgmcdermott.vscode-language-babel
  #language-generic-config
  coolbear.systemd-unit-file
  malmaud.tmux
  deerawan.vscode-dash
  bungcip.better-toml
  https://github.com/microsoft/vscode/issues/33110
  https://github.com/microsoft/vscode/issues/84151
  #pigments
  https://github.com/Microsoft/vscode/issues/12622
  #prettier-atom
  Tyriar.sort-lines
  jeff-hykin.code-eol
  #source-preview
  #tree-view-git-status
  #tree-view-search-bar
  chrislajoie.vscode-modelines
)

code --install-extension "${packages[@]}"
