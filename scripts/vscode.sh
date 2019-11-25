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
  git-time-machine
  language-babel
  language-diff
  language-fish-shell
  language-generic-config
  language-systemd
  language-tmux
  linter
  https://github.com/microsoft/vscode/issues/33110
  linter-bootlint
  linter-shellcheck
  https://github.com/microsoft/vscode/issues/84151
  pigments
  https://github.com/Microsoft/vscode/issues/12622
  prettier-atom
  Tyriar.sort-lines
  jeff-hykin.code-eol
  source-preview
  tree-view-git-status
  tree-view-search-bar
  chrislajoie.vscode-modelines
)

code --install-extension "${packages[@]}"
