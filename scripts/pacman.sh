#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

plasma=(
  kde-applications-meta
  kde-thumbnailer-apk
  kde-thumbnailer-epub
  kdegraphics-meta
  kdegraphics-thumbnailers
  kimageformats
  kwin-lowlatency
  packagekit-qt5
  plasma-meta
  plasma-nm
  plasma-wayland-session
  plasma5-applets-redshift-control
  plasma5-applets-weather-widget
  powerdevil
)

i3=(
  compton-git
  dragon-drag-and-drop-git
  feh
  i3-wm
  i3blocks
  i3lock
  kbdd-git
)

bluetooth=(
  bluedevil
  bluez
  bluez-plugins
  bluez-utils
  pulseaudio-modules-bt-git
  # http://troglobit.com/2017/01/03/trust-bluetooth-4.0-adapter-in-linux/
  bluez-hid2hci
)

lang=(
  firefox-developer-edition-i18n-ru
  firefox-i18n-ru
  hunspell-ru-aot
  kbd-ru-keymaps
  libreoffice-fresh-ru
  man-pages-ru
  thunderbird-i18n-ru
)

packages=(
  # linux from tkg
  # proton from tkg
  # revert mpv to non-git package when 0.30 is out
  # wine from tkg
  # vkd3d from tkg
  #media-video/bluray_info
  #media-video/dvd_info
  #waifu2x-converter-cpp
  #waifu2x-git
  adriconf
  alsa-utils
  amd-ucode
  anbox-git
  android-file-transfer
  android-tools
  appmenu-gtk-module
  appmenu-qt4
  archzfs-dkms
  aria2
  asf
  atom
  atomicparsley
  atool
  audacity
  balena-etcher
  bind-tools
  birdtray
  bleachbit
  blender
  breeze-grub
  btfs
  cantata
  ccache
  cleanerml-git
  cloc
  code
  colordiff
  coolreader
  cpupower
  ctags	
  cuetools
  d-feet
  dasht
  discord
  dkms
  dnscrypt-proxy
  docker
  docker-compose
  docker-gc
  dosbox-svn
  dosbox-x-sdl2
  dosfstools
  doublecmd-plugin-p7z-usr
  doublecmd-qt5
  dupeguru
  electronmail-bin
  espeak
  etc-update
  exfat-utils
  f2fs-tools
  fbreader
  fd
  festival
  ffmpegthumbnailer
  firefox
  firefox-developer-edition
  firejail
  fish
  flashplugin
  flatpak
  #font-manager
  fuse2
  fuse3
  fwupd
  gamemode
  gimp
  godot-blender-exporter
  godot-pulse
  gparted
  gpsd
  grub-libzfs
  haguichi
  gnome-firmware-updater-git
  firmware-manager-git
  htop
  httpie
  i2pd
  iat
  xinput-gui
  aespresso
  igdm
  imagemagick
  innoextract
  iotop
  itch
  jdownloader2
  jdupes
  jpegoptim
  jq
  k3b
  kde-gtk-config
  namespaced-openvpn-git
  kdeconnect
  keepassxc
  kitty
  lector
  lesspipe
  lgogdownloader
  lib32-gamemode
  libappimage 
  libreoffice
  libstrangle-git
  libva-mesa-driver
  libvirt
  links
  linux-firmware
  mpv-mpris-git
  lostfiles
  lsb-release
  lshw
  lsof
  lxrandr
  maim
  mc
  mdf2iso
  mediainfo
  megasync
  mesa
  mesa-demos
  minetest
  mirrorlist-manager
  mkvtoolnix-gui
  mpc
  mpd
  mpdas
  mpv-full-git
  ms-sys
  multimc-git
  mupdf
  mypaint
  neofetch
  netcat
  networkmanager
  networkmanager-openvpn
  networkmanager-pptp
  nmap
  nodejs
  notification-daemon
  nrg2iso
  ntfs-3g
  nyx
  obs-glcapture-git
  obs-linuxbrowser-bin
  obs-studio
  onionshare
  opencl-mesa
  opera-ffmpeg-codecs
  os-prober
  osu-lazer
  oyranos
  p7zip
  p7zip-zstd-codec
  pamix-git
  partitionmanager
  pavucontrol
  pepper-flash 
  phantomjs-bin
  piper
  profile-sync-daemon
  progress
  proxychains
  ps_mem
  pulseaudio
  pulseaudio-alsa
  pulseeffects
  pulsemixer
  pv
  python-cairo
  python-pillow
  python-urwid
  python-xdg
  qalculate-gtk
  qbittorrent  
  qdirstat
  qemu
  qt5
  qt5ct
  qtox
  radeon-profile
  radeon-profile-daemon-git
  ranger
  rclone
  redshift
  remotely-git
  repkg
  ripgrep
  ripme-git
  rivalcfg-git
  rofi
  rssguard
  safeeyes
  sass
  scrot
  sct
  shellcheck
  shntool
  skanlite
  skypeforlinux-stable-bin
  smartmontools
  snapd
  speech-dispatcher
  spotify
  sqlitebrowser
  sshfs
  stow
  strace
  streamlink
  stubby
  subliminal
  sudo
  syncplay
  syncthing
  syncthing-gtk
  syncthingtray
  syslinux
  systemdgenie
  tcpdump
  teamviewer-beta
  telegram-desktop
  texlive-core
  thrash-protect
  git-cola
  thunderbird
  octopi-dev
  octopi-notifier-frameworks
  tig
  sam-rewritten-git
  time
  tldr++
  tmux
  tor
  tor-browser
  torrentinfo
  traceroute
  trackma-git
  translate-shell
  trash-cli
  trebleshot
  twitch-indicator
  unarchiver
  ungoogled-chromium-bin
  unrar
  usb_modeswitch
  veracrypt
  viber
  vifm
  virtio-win
  virtualbox
  virtualbox-ext-oracle
  virtualbox-guest-dkms
  virtualbox-guest-iso
  virtualbox-guest-utils
  virtualbox-host-dkms
  vulkan-mesa-layer
  vulkan-radeon
  w3m
  wget
  whois
  wmctrl
  woeusb
  wxhexeditor
  xautolock
  xclip
  xdelta3
  xdg-desktop-portal
  xdg-desktop-portal-kde
  xdg-user-dirs
  xdotool
  xf86-video-amdgpu
  xorg
  xpadneo-dkms-git
  xsel
  yarn
  zeal
  zip
  zsh
  zsh-completions
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

libretro=(
  libretro-4do-git # RetroAchievements 	✕ The 3DO Company - 3DO
  libretro-beetle-psx-hw-git # RetroAchievements 	✕ PlayStation
  libretro-bluemsx-git
  libretro-bsnes-git  # RetroAchievements 	✔ Nintendo - SNES / Famicom
  libretro-bsnes-mercury-git  # RetroAchievements 	✔ Nintendo - SNES / Famicom
  libretro-citra-git # RetroAchievements 	✕ Nintendo - 3DS
  libretro-desmume-git # RetroAchievements 	✕ Nintendo - DS
  libretro-dolphin-git # RetroAchievements 	✕ Nintendo Gamecube/Wii
  libretro-dosbox-git # RetroAchievements 	✕ DOS
  libretro-fbneo-git
  libretro-fceumm-git # RetroAchievements 	✔ Nintendo - NES / Famicom
  libretro-flycast-git # RetroAchievements 	✕ Sega Dreamcast
  libretro-fmsx-git
  libretro-fmsx-git
  libretro-fuse-git # RetroAchievements 	✕ ZX Spectrum (Fuse)
  libretro-gambatte-git # RetroAchievements 	✔ GB/GBC Nintendo - Game Boy / Color # https://github.com/libretro/gambatte-libretro/pull/123 !!!!!!!1
  libretro-genesis-plus-gx-git # RetroAchievements 	✔ Sega - MS/GG/MD/CD
  libretro-gw-git # RetroAchievements 	✕ Handheld Electronic
  libretro-higan # RetroAchievements 	✕ Nintendo - SNES / Famicom
  libretro-mame2003-plus-git # RetroAchievements 	✕
  libretro-mgba-git # RetroAchievements         ✔ (GBA only) Nintendo - Game Boy Advance
  libretro-mrboom-git
  libretro-nestopia-git # RetroAchievements 	✕ Nintendo - NES / Famicom
  libretro-overlays-git
  libretro-parallel-n64-git # RetroAchievements 	✔ Nintendo 64
  libretro-pcsx-rearmed-git # RetroAchievements 	✕ Sony - PlayStation
  libretro-picodrive-git # RetroAchievements 	✔ Sega - MS/MD/CD/32X
  libretro-pokemini-git # RetroAchievements 	✕ Nintendo - Pokémon Mini
  libretro-ppsspp-git # RetroAchievements 	✕ Sony - PlayStation Portable
  libretro-sameboy-git # RetroAchievements     ✔ GB/GBC Nintendo - Game Boy / Color
  libretro-snes9x-git # RetroAchievements 	✔ Nintendo - SNES / Famicom
  libretro-vba-next-git # RetroAchievements     ✔ Nintendo - Game Boy Advance
  retroarch
  xdg-utils
)

games=(
  cataclysm-dda-tiles
  citra-canary-git
  colobot-gold
  colobot-gold-music
  linux-steam-integration
  lutris
  lutris-battlenet-meta
  lutris-world-of-warcraft-dependencies-amd
  lutris-wine-meta
  ninfs-gui
  openmw-git
  openra
  openra-ra2-git
  oversteer
  jstest-gtk-git
  gltron
  gb-studio-git
  freej2me
  openrw-git 
  openspades-git
  openttd
  pcsx2-git
  pcsx2-plugin-usbqemu-wheel
  play-emu-ninja-git
  protonfixes-git
  protontricks-git
  residualvm-git
  rpcs3-git
  steam
  steam-fonts
  steam-native-runtime
  boxtron-git
  taisei-git
  vitetris
  winetricks-git
  xash3d-git
  yuzu-canary-git
)

wine=(
  gallium-nine-git
  gst-plugins-bad
  gst-plugins-ugly
  lib32-gallium-nine-git
  lib32-gst-plugins-bad
  lib32-gst-plugins-base
  lib32-gst-plugins-ugly
  wine_gecko
  wine-mono
  spirv-headers-git
)

# Upgrade any already-installed packages.
yay -S "${packages[@]}" "${fonts[@]}" "${libretro[@]}" "${plasma[@]}" "${i3[@]}" "${lang[@]}" "${games[@]}" "${wine[@]}" "${bluetooth[@]}"

# Remove outdated versions from the pacman.
yay -c
