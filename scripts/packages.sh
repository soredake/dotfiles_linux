#!/bin/bash

sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
sudo add-apt-repository -y ppa:kisak/kisak-mesa
sudo add-apt-repository -y ppa:libretro/stable
sudo add-apt-repository -y ppa:lutris-team/lutris
sudo add-apt-repository -y ppa:cdemu/ppa
sudo add-apt-repository -y ppa:samoilov-lex/retrogames
sudo add-apt-repository -y ppa:maxiberta/kwin-lowlatency
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key add -

sudo apt update
sudo apt full-upgrade

wget --content-disposition 'https://go.microsoft.com/fwlink/?LinkID=760868'
sudo apt install ./code*.deb
wget --content-disposition 'https://discord.com/api/download?platform=linux&format=deb'
sudo apt install ./discord*.deb
wget --content-disposition https://files.multimc.org/downloads/multimc_1.4-1.deb
sudo apt install ./multimc*.deb
wget --content-disposition https://github.com/chrismaltby/gb-studio/releases/download/v1.2.1/GB-Studio-Linux-DEB-1.2.1.zip
sudo apt install ./gb-studio*.deb

optdeps=(
  # kio-extras kfilemetadata
  libappimage0
  # kde-service-menu-reimage
  jhead
  # dolphin
  dolphin-plugins
  # kde
  colord-kde
)

packages=(
  android-tools-adb
  aria2
  aspell-ru
  cantata
  earlyoom
  fd-find
  filelight
  fish
  flatpak plasma-discover-backend-flatpak
  gimp
  git git-cola gitk
  htop
  jdupes
  keepassxc
  kitty
  kompare
  krename
  kubuntu-restricted-extras
  linux-tools-common
  linux-xanmod
  megatools
  meld
  mpd
  mpv
  myspell-ru
  obs-studio
  parallel
  proxychains4
  pulseaudio-modules-bt
  python3-pip
  qbittorrent
  qdirstat
  rclone
  ripgrep
  safeeyes
  seahorse
  shellcheck
  sirikali cryfs
  smartmontools
  stow
  sweeper
  syncthing
  telegram-desktop
  thunderbird
  tor
  torbrowser-launcher
  translate-shell
  xclip
  yarn
  youtube-dl
  zeal
)

fonts=(
  # https://github.com/gentoo/gentoo/tree/master/media-fonts/infinality-ultimate-meta
  # https://github.com/gentoo/gentoo/tree/master/www-client/chromium
  cantarell-fonts
  noto-fonts{,-cjk,-emoji,-extra}
  ttf-dejavu
  ttf-droid
  ttf-hack
  ttf-inconsolata
  ttf-liberation
  ttf-ms-fonts
  ttf-opensans
  ttf-ubuntu-font-family
)

games=(
  cataclysm-dda-sdl
  colobot
  gamemode
  gcdemu
  lutris
  openmw
  pcsx2 citra yuzu
  residualvm
  retroarch
  scummvm
  steam
  vitetris
  # lutris
  mesa-vulkan-drivers mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 libgnutls30:i386 libldap-2.4-2:i386 libgpg-error0:i386 libxml2:i386 libasound2-plugins:i386 libsdl2-2.0-0:i386 libfreetype6:i386 libdbus-1-3:i386 libsqlite3-0:i386
)

sudo apt install --install-recommends wine-staging

# Install my packages
sudo apt install "${packages[@]}" "${fonts[@]}" "${games[@]}" "${optdeps[@]}"

flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak --user install flathub com.viber.Viber
flatpak --user install flathub org.jdownloader.JDownloader
flatpak --user install flathub org.taisei_project.Taisei
snap install copay
snap install dosbox-staging
snap install open-syobon-action
snap install syncplay --classic
pip3 install git+https://github.com/simons-public/protonfixes@master
pip3 install internetarchive
pip3 install protontricks
pip3 install anime-downloader
pip3 install Trackma
pip3 install https://github.com/ihaveamac/ninfs/archive/2.0.zip#egg=ninfs[gui] # TODO: https://github.com/ihaveamac/ninfs/issues/57
ninfs --install-desktop-entry

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