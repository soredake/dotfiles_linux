#!/bin/bash

sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
sudo add-apt-repository -y ppa:kisak/kisak-mesa
sudo add-apt-repository -y ppa:libretro/stable
sudo add-apt-repository -y ppa:lutris-team/lutris
sudo add-apt-repository -y ppa:cdemu/ppa
sudo add-apt-repository -y ppa:kubuntu-ppa/backports
sudo add-apt-repository -y ppa:jonaski/strawberry
sudo add-apt-repository -y ppa:samoilov-lex/retrogames
sudo add-apt-repository -y ppa:maxiberta/kwin-lowlatency
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key add -
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61

sudo apt update
sudo apt upgrade -y

wget --content-disposition 'https://go.microsoft.com/fwlink/?LinkID=760868'
sudo apt install -y ./code*.deb
wget --content-disposition 'https://discord.com/api/download?platform=linux&format=deb'
sudo apt install -y ./discord*.deb
wget --content-disposition https://files.multimc.org/downloads/multimc_1.4-1.deb
sudo apt install -y ./multimc*.deb
wget --content-disposition https://github.com/chrismaltby/gb-studio/releases/download/v1.2.1/GB-Studio-Linux-DEB-1.2.1.zip
unzip GB-Studio*.zip
sudo apt install -y ./gb-studio*.deb

optdeps=(
  # kde-service-menu-reimage
  jhead
  # dolphin
  dolphin-plugins
  # kde
  colord-kde
  # pulseaudio
  pulseaudio-module-gsettings
)

packages=(
  android-tools-adb
  balena-etcher-electron
  bleachbit
  earlyoom
  fd-find
  filelight
  fish
  gimp
  git-cola
  gitk
  htop
  jdupes
  keepassxc
  chromium-browser
  kitty
  kompare
  linux-xanmod
  mpv
  obs-studio
  parallel
  proxychains4
  pulseaudio-modules-bt
  python3-pip
  qbittorrent
  rclone
  ripgrep
  safeeyes
  shellcheck
  smartmontools
  stow
  strawberry
  syncthing
  telegram-desktop
  translate-shell
  xclip
  yarn
  youtube-dl
  zeal
)

games=(
  cataclysm-dda-sdl
  citra
  colobot
  gcdemu
  lutris
  openmw
  pcsx2
  residualvm
  retroarch
  scummvm
  vitetris
  yuzu
)

sudo apt install --install-recommends --install-suggests -y lutris winetricks
sudo apt install --install-recommends -y winehq-stable steam torbrowser-launcher sirikali kubuntu-restricted-extras

# Install my packages
sudo apt install -y "${packages[@]}" "${games[@]}" "${optdeps[@]}"

flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak --user install flathub org.jdownloader.JDownloader org.taisei_project.Taisei
snap install copay
snap install dosbox-staging
snap install open-syobon-action
pip=(
  anime-downloader
  git+https://github.com/simons-public/protonfixes@master
  internetarchive
  protontricks
)
pip3 install -U "${pip[@]}"

vspackages=(
  EditorConfig.EditorConfig
  HookyQR.beautify
  Tyriar.sort-lines
  anseki.vscode-color
  bmalehorn.vscode-fish
  bungcip.better-toml
  chrislajoie.vscode-modelines
  coolbear.systemd-unit-file
  deerawan.vscode-dash
  eamodio.gitlens
  file-icons.file-icons
  geekidos.vdf
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

parallel -j 1 code --install-extension ::: "${vspackages[@]}"