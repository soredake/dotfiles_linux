#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

plasma=(
  kdeaccessibility-meta
  kdeadmin-meta
  kdebase-meta
  kdeedu-meta
  kdegames-meta
  kdegraphics-meta
  kdemultimedia-meta
  kdenetwork-meta
  kdepim-meta
  kdeutils-meta
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
  xautolock
  rofi
  compton-git
  dragon-drag-and-drop-git
  feh
  i3-wm
  i3blocks
  i3blocks-contrib
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
  hunspell-ru-aot
  kbd-ru-keymaps
  man-pages-ru
)

mesa=(
  libva-mesa-driver
  mesa
  mesa-demos
  opencl-mesa
  vulkan-mesa-layer
  vulkan-radeon
  xf86-video-amdgpu
)

packages=(
  # linux from tkg
  # proton from tkg
  # vkd3d from tkg
  # wine from tkg
  #media-video/bluray_info
  #media-video/dvd_info
  #mypaint
  #waifu2x-converter-cpp
  #waifu2x-git
  adriconf
  aespresso
  alsa-utils
  amd-ucode
  android-file-transfer
  android-tools
  appmenu-gtk-module
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
  curlie
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
  falkon
  fbreader
  fd
  festival
  ffmpegthumbnailer
  firefox
  firejail
  firmware-manager-git
  fish
  flashplugin
  flatpak
  fuse2
  fwupd
  gamemode
  gimp
  git-cola
  gnome-disk-utility
  gnome-firmware
  go-pie
  godot-blender-exporter
  godot-pulse
  gparted
  gpsd
  grub-libzfs
  haguichi
  htop
  httpie
  i2pd
  iat
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
  kdeconnect
  keepassxc
  kitty
  kompare
  lector
  lesspipe
  lgogdownloader
  lib32-gamemode
  libappimage 
  libreoffice
  libstrangle-git
  libvirt
  links
  linux-firmware
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
  mirrorlist-manager
  mkvtoolnix-gui
  mpc
  mpd
  mpdas
  mpv-full-git
  mpv-mpris-git
  ms-sys
  nano
  linux
  multimc5
  mupdf
  namespaced-openvpn-git
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
  nvme-cli
  nyx
  obs-glcapture-git
  obs-linuxbrowser-bin
  obs-studio
  octopi-dev
  octopi-notifier-frameworks
  onionshare
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
  rssguard
  safeeyes
  sam-rewritten-git
  sass
  scrot
  sct
  shellcheck
  shntool
  skanlite
  skypeforlinux-stable-bin
  smartmontools
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
  base # https://www.archlinux.org/news/base-group-replaced-by-mandatory-base-package-manual-intervention-required/
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
  translate-shell
  trash-cli
  trebleshot
  twitch-indicator
  unarchiver
  unrar
  usb_modeswitch
  veracrypt
  viber
  vifm
  virtio-win
  w3m
  grub-customizer
  wget
  whois
  wmctrl
  woeusb
  wxhexeditor
  xclip
  xdelta3
  xdg-desktop-portal
  xdg-desktop-portal-kde
  xdg-user-dirs
  xdotool
  xinput-gui
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
  #libretro-neocd-git # RetroAchievements     ✔ Nintendo - Game Boy Advance
  #libretro-vba-m-git # RetroAchievements     ✔ Nintendo - Game Boy Advance
  libretro-4do-git # RetroAchievements 	✕ The 3DO Company - 3DO
  libretro-beetle-psx-hw-git # RetroAchievements 	(https://retroachievements.org/viewtopic.php?t=9302) ✔ PlayStation
  libretro-bluemsx-git # RetroAchievements 	✕ MSX/SVI/ColecoVision/SG-1000
  libretro-bsnes-hd-git  # RetroAchievements 	✔ Nintendo - SNES / Famicom
  libretro-bsnes-mercury-git  # RetroAchievements 	✔ Nintendo - SNES / Famicom
  libretro-citra-git # RetroAchievements 	✕ Nintendo - 3DS
  libretro-desmume-git # RetroAchievements 	✕ Nintendo - DS
  libretro-dolphin-git # RetroAchievements 	✕ Nintendo Gamecube/Wii
  libretro-dosbox-git # RetroAchievements 	✕ DOS
  libretro-fbneo-git
  libretro-fceumm-git # RetroAchievements 	✔ Nintendo - NES / Famicom
  libretro-flycast-git # RetroAchievements 	✕ Sega Dreamcast
  libretro-fmsx-git # RetroAchievements 	✕ MSX
  libretro-fuse-git # RetroAchievements 	✕ ZX Spectrum (Fuse)
  libretro-gambatte-git # RetroAchievements 	✔ GB/GBC Nintendo - Game Boy / Color # https://github.com/libretro/gambatte-libretro/pull/123 !!!!!!!1
  libretro-genesis-plus-gx-git # RetroAchievements 	✔ Sega - MS/GG/MD/CD
  libretro-gw-git # RetroAchievements 	✕ Handheld Electronic
  libretro-mame2003-plus-git # RetroAchievements 	✕
  libretro-mgba-git # RetroAchievements         ✔ (GBA only) Nintendo - Game Boy Advance
  libretro-mrboom-git
  libretro-mupen64plus-nx-git # RetroAchievements 	✔ Nintendo 64
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
  boxtron-git
  cataclysm-dda-tiles
  citra-canary-git
  colobot-gold
  colobot-gold-music
  freej2me
  gb-studio-git
  gltron
  jstest-gtk-git
  linux-steam-integration
  lutris
  lutris-battlenet-meta
  lutris-wine-meta
  lutris-world-of-warcraft-dependencies-amd
  ninfs-gui
  openmw-git
  openra
  openra-ra2-git
  openrw-git 
  openspades-git
  openttd
  oversteer
  minetest
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
  syobon
  taisei-git
  vita3k-git
  vitetris
  winetricks-git
  xash3d-git
  xboxdrv
  yuzu-canary-git
)

wine=(
  wine-nine
  gst-plugins-bad
  gst-plugins-ugly
  lib32-gallium-nine-git
  lib32-gst-plugins-bad
  lib32-gst-plugins-base
  lib32-gst-plugins-ugly
  spirv-headers-git
  wine_gecko
  wine-mono
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
yay -S "${packages[@]}" "${fonts[@]}" "${libretro[@]}" "${plasma[@]}" "${i3[@]}" "${lang[@]}" "${games[@]}" "${wine[@]}" "${bluetooth[@]}"

# Remove outdated versions from the pacman.
yay -c
