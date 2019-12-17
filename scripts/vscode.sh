#!/bin/bash

packages=(
  #https://github.com/Microsoft/vscode/issues/12622
  #https://github.com/microsoft/vscode/issues/33110
  #https://github.com/microsoft/vscode/issues/84151
  EditorConfig.EditorConfig
  Tyriar.sort-lines
  advanced-open-file
  anseki.vscode-color
  atom-beautify
  bungcip.better-toml
  chrislajoie.vscode-modelines
  coolbear.systemd-unit-file
  deerawan.vscode-dash
  eamodio.gitlens
  file-icons.file-icons
  jaspernorth.vscode-pigments
  jeff-hykin.code-eol
  mads-hartmann.bash-ide-vscode
  jaydenlin.ctags-support
  malmaud.tmux
  mgmcdermott.vscode-language-babel
  timonwong.shellcheck
  wayou.vscode-todo-highlight
  ulthes.theme-firewatch
)

codium --install-extension "${packages[@]}"