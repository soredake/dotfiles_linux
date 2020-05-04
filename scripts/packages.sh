#!/bin/bash

# https://www.archlinux.org/packages/extra/any/kde-applications-meta/
plasma=(
  # kdeadmin-meta start
  ksystemlog
  # kdeadmin-meta end
  # kdebase-meta start
  dolphin
  kdialog
  kfind
  khelpcenter
  # kdebase-meta end
  # kdegraphics-meta start
  kdegraphics-meta
  # kdegraphics-meta end
  # kdemultimedia-meta start
  ffmpegthumbs
  # kdemultimedia-meta end
  # kdenetwork-meta start
  kdenetwork-filesharing
  kio-extras
  krdc
  krfb
  telepathy-kde-meta
  zeroconf-ioslave
  # kdenetwork-meta end
  # kdepim-meta start
  akonadi-calendar-tools
  akonadiconsole
  kaddressbook
  kalarm
  kdepim-addons
  knotes
  kontact
  korganizer
  # kdepim-meta end
  # kdesdk-meta start
  dolphin-plugins
  kompare
  # kdesdk-meta end
  # kdeutils-meta start
  ark
  filelight
  kcalc
  kcharselect
  kdf
  kgpg
  kteatime
  ktimer
  kwalletmanager
  sweeper
  # kdeutils-meta end
  colord-kde
  kde-service-menu-reimage
  kde-servicemenus-rootactions
  kwin-lowlatency
  plasma-meta
  plasma-wayland-session
  plasma5-applets-weather-widget
)

drv=(
  xf86-video-amdgpu
  {lib32-,}libva-mesa-driver
  {lib32-,}vulkan-radeon
)

optdeps=(
  # plasma-workspace
  appmenu-gtk-module
  # kio-extras kfilemetadata
  libappimage
  # htop
  lsof
  # code
  ctags bash-language-server
  # kde-service-menu-reimage
  jhead
  # pulseaudio
  pulseaudio-alsa
  # kio-extras gwenview
  kimageformats
  # dolphin
  konsole
  # kio
  kio-fuse
  # python-internetarchive
  python-ujson python-gevent
  # syncplay
  python-certifi python-service-identity
  # ark okular
  unrar
)

packages=(
  ancient-packages
  android-tools
  archiso
  aria2
  aspell-ru
  base
  bluez-plugins
  bluez-utils
  cantata
  ccache
  code
  cpupower
  discord
  dnscrypt-proxy
  downgrade
  dupeguru
  earlyoom
  etc-update
  etcher-bin
  fd
  firefox
  flatpak
  fwupd
  gimp
  git-cola
  gparted
  grub grub-hook os-prober
  hdparm
  htop
  hunspell-ru-aot
  jdupes
  keepassxc
  kitty
  kompare
  krename
  lector
  libstrangle-git
  linux-{firmware,tkg-pds-zen{,-headers}} amd-ucode kernel-modules-hook
  man-db man-pages
  megatools
  meld
  mpd
  mpv{,-mpris,-webm-git}
  nano
  networkmanager{,-pptp,-openvpn}
  ntfs-3g
  obs-studio
  paccache-hook
  parallel
  piper
  pkgtop
  proxychains-ng
  pulseaudio-modules-bt-git
  python-internetarchive
  qbittorrent
  qdirstat
  rclone
  ripgrep
  ripme
  safeeyes
  samrewritten-git
  seahorse
  shellcheck
  sirikali cryfs
  smartmontools
  snapd
  sshfs
  stow
  sudo
  syncplay
  syncthing
  systemdgenie
  telegram-desktop
  thunderbird
  tldr++
  tor tor-browser
  trackma-git adl-git
  translate-shell
  viber
  wget
  xclip
  xdg-user-dirs
  xorg-{server,server-xwayland,xgamma}
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
  boxtron
  cataclysm-dda-tiles
  citra-canary-git
  colobot-gold colobot-gold-music
  dosbox-staging
  flips-git
  gb-studio-bin
  itch
  lib32-gamemode
  lutris
  lutris-wine-meta
  luxtorpeda
  mingw-w64-gcc
  multimc5
  ninfs-gui
  openmw
  proton-ge-custom-bin
  protonfixes-git
  protontricks
  residualvm
  retroarch
  roberta
  rpcs3-bin
  scummvm
  steam
  steascree
  syobon
  taisei
  vita3k-git
  vitetris
  vkbasalt
  wine-mono-bin wine-gecko
  wine-tkg-staging-fsync-vkd3d-git # TODO: move to staging when mingw and fs{-hack,-bypass,-scaling,ync} is merged
  winetricks
  yuzu-mainline-git
  {lib32-,}faudio-git
  {lib32-,}gst-plugins-bad
  {lib32-,}gst-plugins-base
  {lib32-,}gst-plugins-good
  {lib32-,}gst-plugins-ugly
  {lib32-,}vkd3d
  # https://wiki.archlinux.org/index.php/CDemu
  kde-cdemu-manager-kf5 cdemu-client vhba-module-dkms
)

# Upgrade any already-installed packages.
yay -Syuu

# Install my packages
yay -S "${packages[@]}" "${fonts[@]}" "${drv[@]}" "${plasma[@]}" "${games[@]}" "${optdeps[@]}"

# https://wiki.archlinux.org/index.php/Flatpak#Add_a_repository
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak --user install flathub org.jdownloader.JDownloader
flatpak --user install flathub net.pcsx2.PCSX2
snap install copay

vspackages=(
  #https://github.com/Microsoft/vscode/issues/12622
  #https://github.com/microsoft/vscode/issues/33110
  #https://github.com/microsoft/vscode/issues/84151
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
  geekidos.vdf
)

code --install-extension "${vspackages[@]}"