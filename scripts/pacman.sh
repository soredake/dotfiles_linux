#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

plasma=(
  akonadi-calendar-tools
  akonadiconsole
  ark
  dolphin
  dolphin-plugins
  ffmpegthumbs
  filelight
  kaddressbook
  kate
  kcalc
  kcharselect
  kde-thumbnailer-apk
  kde-thumbnailer-epub
  kdegraphics-meta
  kdegraphics-thumbnailers
  kdenetwork-filesharing
  kdenetwork-meta
  kdepim-addons
  kdepim-meta
  kdeutils-meta
  kdf
  kdialog
  kfind
  khelpcenter
  kimageformats
  knotes
  kde-servicemenus-rootactions
  kde-service-menu-reimage
  kompare
  kontact
  korganizer
  ksystemlog
  ktimer
  kwalletmanager
  kwin-lowlatency
  packagekit-qt5
  plasma-meta
  plasma-nm
  plasma-wayland-session
  plasma5-applets-redshift-control
  plasma5-applets-weather-widget
  powerdevil
  print-manager
  telepathy-kde-meta
  zeroconf-ioslave
)

i3=(
  dragon-drag-and-drop-git
  fe
  kbdd-git
  links
  pavucontrol
  maim
  pamix-git
  pulsemixer
  rofi
  scrot
  sct
  network-manager-applet
  vifm
  wmctrl
  xautolock
  xsel
)

bluetooth=(
  bluedevil
  bluez
  bluez-plugins
  bluez-utils
  pulseaudio-modules-bt-git
)

lang=(
  hunspell-ru-aot
  kbd-ru-keymaps
)

mesa=(
  libva-mesa-driver lib32-libva-mesa-driver
  mesa lib32-mesa
  mesa-demos lib32-mesa-demos
  opencl-mesa
  vulkan-mesa-layer lib32-vulkan-mesa-layer
  vulkan-radeon lib32-vulkan-radeon
  xf86-video-amdgpu
  llvm lib32-llvm
)

optdeps=(
  # bleachbit-git
  cleanerml-git
  # plasma-workspace
  appmenu-gtk-module
  # firefox
  speech-dispatcher espeak-ng festival
  # plasma-meta
  kde-gtk-config
  # jdownloader2
  phantomjs-bin
  # ranger
  ffmpegthumbnailer
  # kio-extras kfilemetadata
  libappimage
  # htop
  lsof
  # yuzu binary dep
  sndio
  # atom
  ctags
  # youtube-dl
  atomicparsley
  # kde-service-menu-reimage
  jhead
  # vscode dep
  #bash-language-server
)

packages=(
  # proton from tkg
  # wine from tkg
  #media-video/dvd_info
  aespresso
  # alsamixer
  alsa-utils
  android-file-transfer
  android-tools
  aria2
  asf
  atom
  atool
  linux-tkg-pds-zen linux-tkg-pds-zen-headers
  audacity
  balena-etcher
  # https://www.archlinux.org/news/base-group-replaced-by-mandatory-base-package-manual-intervention-required/
  base
  bleachbit
  blender
  btfs
  cantata
  ccache
  cloc
  code
  colordiff
  cpupower
  curlie
  dasht
  discord
  dnscrypt-proxy
  docker
  docker-compose
  dosbox
  # mkfs.fat mkfs.exfat
  dosfstools exfat-utils
  dupeguru
  electronmail-bin
  etc-update
  evtest
  falkon
  fd
  firefox
  firejail
  pkgtop
  firmware-manager-git
  flashplugin
  flatpak
  fwupd
  gimp
  git-cola
  gnome-disk-utility
  gnome-firmware
  go-pie
  godot-pulse godot-blender-exporter
  gparted
  # https://wiki.archlinux.org/index.php/GRUB/Tips_and_tricks#Theme
  grub breeze-grub grub-customizer
  guiscrcpy
  haguichi
  htop
  httpie
  innoextract
  iotop
  itch
  meld
  jdupes
  jpegoptim
  jq
  kdeconnect
  keepassxc
  kitty
  kompare
  lector
  lesspipe 
  libreoffice
  libstrangle-git
  linux linux-firmware amd-ucode
  lostfiles
  lshw
  lxrandr
  mc
  mediainfo
  megasync
  mirrorlist-manager
  mkvtoolnix-gui
  mpc mpd
  mpv mpv-mpris-git
  multimc5
  namespaced-openvpn-git
  nano
  neofetch
  networkmanager networkmanager-pptp networkmanager-openvpn
  nmap
  nodejs yarn
  ntfs-3g
  nvme-cli
  obs-studio obs-linuxbrowser-bin obs-glcapture-git
  octopi-notifier-frameworks
  os-prober
  oyranos
  krename
  fatrace
  p7zip
  p7zip-zstd-codec
  partitionmanager
  pepper-flash
  piper
  progress
  proxychains
  ps_mem
  pulseaudio-alsa
  pulseeffects
  pv
  qalculate-gtk
  qbittorrent  
  qdirstat
  radeon-profile radeon-profile-daemon-git
  ranger
  rclone
  redshift
  remotely-git
  ripgrep
  ripme-git
  rssguard
  safeeyes
  samrewritten-git
  shellcheck
  skanlite
  smartmontools
  downgrade
  man-db man-pages
  spotify
  joyutils
  sqlitebrowser
  sshfs
  stow
  streamlink
  sudo
  syncplay
  syncthing syncthingtray
  #displaycal colord-kde
  systemdgenie
  teamviewer
  telegram-desktop
  thrash-protect
  thunderbird
  tig
  time
  tldr++
  tmux
  tor
  tor-browser
  torrentinfo
  traceroute
  trackma-git
  kdocker
  translate-shell
  trash-cli
  downgrade
  trebleshot
  twitch-indicator
  unarchiver
  unrar zip
  viber
  wget
  whois
  woeusb
  wxhexeditor
  xclip xdotool
  xdg-user-dirs
  xorg
  zeal
  zsh zsh-completions
)
fonts=(
  # https://gpo.zugaina.org/media-fonts/infinality-ultimate-meta
  # https://gpo.zugaina.org/www-client/chromium
  cantarell-fonts
  font-bh-ttf
  mplus-font
  noto-fonts
  otf-ipaexfont
  otf-takao
  terminus-font
  tex-gyre-fonts
  ttf-baekmuk
  ttf-bitstream-vera
  ttf-courier-prime
  ttf-dejavu
  ttf-droid
  ttf-hack
  ttf-inconsolata
  ttf-kochi-substitute
  ttf-koruri
  ttf-liberation
  ttf-mikachan
  ttf-ms-fonts
  ttf-opensans
  ttf-paratype
  ttf-sazanami
  ttf-signika
  ttf-symbola
  ttf-ubuntu-font-family
  ttf-unfonts-core-ibx
  ttf-vlgothic
  wqy-microhei
  wqy-zenhei
)

games=(
  boxtron
  cataclysm-dda-tiles
  colobot-gold
  colobot-gold-music
  freej2me
  gamemode lib32-gamemode
  gb-studio-git
  gltron
  jstest-gtk-git
  lutris-battlenet-meta
  lutris-git
  lutris-wine-meta
  lutris-world-of-warcraft-dependencies-amd
  ninfs-gui
  openmw
  openttd
  osu-lazer
  oversteer
  pcsx2-git
  pcsx2-plugin-usbqemu-wheel
  protonfixes-git
  protontricks-git
  residualvm-git
  retroarch
  rpcs3-git
  scummvm-git
  steam
  steam-fonts
  steam-native-runtime
  syobon
  taisei
  vitetris
  winetricks-git
  xboxdrv
  xdg-utils
  yuzu-mainline-git
  # https://wiki.archlinux.org/index.php/CDemu
  kde-cdemu-manager-kf5 cdemu-client vhba-module-dkms
  flips-git
)

wine=(
  gst-plugins-bad lib32-gst-plugins-bad
  gst-plugins-ugly lib32-gst-plugins-ugly
  gst-plugins-base lib32-gst-plugins-base
  gst-plugins-good lib32-gst-plugins-good
  vkd3d lib32-vkd3d
  wine_gecko
  wine-mono
  wine-nine
)

virtualbox=(
  virtualbox
  virtualbox-ext-oracle
  virtualbox-guest-dkms
  virtualbox-guest-iso
  virtualbox-guest-utils
  virtualbox-host-dkms
)

# Upgrade any already-installed packages.
yay -Syuu

# Install optdeps
yay -S --asdeps "${optdeps[@]}"

# Install my packages
yay -S "${packages[@]}" "${fonts[@]}" "${mesa[@]}" "${plasma[@]}" "${lang[@]}" "${games[@]}" "${wine[@]}" "${bluetooth[@]}"

# not in use anymore
yay -S "${i3[@]}" "${virtualbox[@]}"

# Remove outdated versions from the pacman.
yay -c
