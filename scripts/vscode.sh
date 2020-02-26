#!/bin/bash

packages=(
  #https://github.com/Microsoft/vscode/issues/12622
  #https://github.com/microsoft/vscode/issues/33110
  #https://github.com/microsoft/vscode/issues/84151
  EditorConfig.EditorConfig
  HookyQR.beautify
  Tyriar.sort-lines
  anseki.vscode-color
  bungcip.better-toml
  chrislajoie.vscode-modelines
  coolbear.systemd-unit-file
  deerawan.vscode-dash
  eamodio.gitlens
  file-icons.file-icons
  jaspernorth.vscode-pigments
  jaydenlin.ctags-support
  jeff-hykin.code-eol
  jit-y.vscode-advanced-open-file
  mads-hartmann.bash-ide-vscode
  malmaud.tmux
  mgmcdermott.vscode-language-babel
  timonwong.shellcheck
  ulthes.theme-firewatch
  wayou.vscode-todo-highlight
)

codium --install-extension "${packages[@]}"