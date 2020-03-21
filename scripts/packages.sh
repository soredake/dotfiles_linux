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
  plasma5-applets-redshift-control-git
  plasma5-applets-weather-widget
)

bluetooth=(
  bluez-plugins
  bluez-utils
  pulseaudio-modules-bt-git
)

lang=(
  aspell-ru
  hunspell-ru-aot
  kbd-ru-keymaps
)

mesa=(
  libva-mesa-driver lib32-libva-mesa-driver
  mesa lib32-mesa
  radeon-profile-git radeon-profile-daemon-git
  vulkan-mesa-layer lib32-vulkan-mesa-layer
  vulkan-radeon lib32-vulkan-radeon
  xf86-video-amdgpu
)

optdeps=(
  # plasma-workspace
  appmenu-gtk-module
  # kio-extras kfilemetadata
  libappimage
  # htop
  lsof
  # vscodium
  ctags
  # kde-service-menu-reimage
  jhead
  # vscode dep
  bash-language-server
  # minecraft-launcher
  flite
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
  python-certifi python-service_identity
)

packages=(
  ancient-packages
  android-tools
  archiso
  aria2
  etcher-bin
  base
  bleachbit
  cantata
  ccache
  cpupower
  discord
  dnscrypt-proxy
  downgrade
  dupeguru
  electronmail-bin
  etc-update
  fatrace
  fd
  firefox
  flatpak
  fwupd
  ghex
  gimp
  git-cola
  godot-bin
  gparted
  grub grub-hook os-prober
  htop
  innoextract
  jdupes
  jre-openjdk jdk-openjdk
  kdeconnect
  keepassxc
  kitty
  kompare
  krename
  lector
  libstrangle-git
  linux linux-firmware amd-ucode kernel-modules-hook kexec-tools
  lostfiles
  man-db man-pages
  megasync
  meld
  mpd
  mpv mpv-mpris mpv-webm-git
  nano
  networkmanager networkmanager-pptp networkmanager-openvpn
  ntfs-3g
  obs-studio
  p7zip
  paccache-hook
  piper
  pkgtop
  proxychains-ng
  python-internetarchive
  qbittorrent
  qdirstat
  ranger
  rclone
  redshift
  riot-desktop
  ripgrep
  ripme-git
  rssguard
  safeeyes
  samrewritten-git
  seahorse
  shellcheck
  sirikali cryfs
  smartmontools
  snapd
  spotify
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
  tutanota-desktop-bin
  unrar zip
  viber
  vscodium-bin
  wget
  xclip xdotool
  xdg-user-dirs
  xorg-server xorg-server-xwayland xorg-xgamma xorg-xhost xorg-xinput
  yarn
  youtube-dl
  zeal
  zsh zsh-completions
)

fonts=(
  # https://github.com/gentoo/gentoo/tree/master/media-fonts/infinality-ultimate-meta
  # https://github.com/gentoo/gentoo/tree/master/www-client/chromium
  cantarell-fonts
  font-bh-ttf
  mplus-font
  noto-fonts
  terminus-font
  ttf-baekmuk
  ttf-bitstream-vera
  ttf-courier-prime
  ttf-dejavu
  ttf-droid
  ttf-hack
  ttf-inconsolata
  ttf-koruri
  ttf-liberation
  ttf-ms-fonts
  ttf-opensans
  ttf-paratype
  ttf-signika
  ttf-ubuntu-font-family
  ttf-vlgothic
)

games=(
  boxtron
  cataclysm-dda-tiles
  citra-canary-git
  colobot-gold colobot-gold-music
  decaf-emu-git
  dosbox-staging
  flips-git
  gb-studio-bin
  itch
  lib32-gamemode
  lutris-git # TODO: non-git after 0.5.5 is out
  lutris-wine-meta
  lutris-world-of-warcraft-dependencies-amd
  luxtorpeda
  mame
  multimc5
  ninfs-gui
  openmw-git
  protonfixes-updated-git
  protontricks
  residualvm
  retroarch
  roberta
  rpcs3-bin
  scummvm
  steam
  syobon
  taisei
  vita3k-git
  vitetris
  vkbasalt
  wine-tkg-staging-fsync-vkd3d-git
  winetricks-git # TODO: move to bin
  yuzu-mainline-git
  # https://wiki.archlinux.org/index.php/CDemu
  kde-cdemu-manager-kf5 cdemu-client vhba-module
)

wine=(
  gst-plugins-bad lib32-gst-plugins-bad
  gst-plugins-base lib32-gst-plugins-base
  gst-plugins-good lib32-gst-plugins-good
  gst-plugins-ugly lib32-gst-plugins-ugly
  vkd3d lib32-vkd3d
  wine-mono-bin wine-gecko
)

# Upgrade any already-installed packages.
yay -Syuu

# Install my packages
yay -S "${packages[@]}" "${fonts[@]}" "${mesa[@]}" "${plasma[@]}" "${lang[@]}" "${games[@]}" "${wine[@]}" "${bluetooth[@]}" "${optdeps[@]}"

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
)

codium --install-extension "${vspackages[@]}"