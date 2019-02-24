#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

plasma=(
  kde-applications-meta
  kde-thumbnailer-apk
  kde-thumbnailer-epub
  kdegraphics-thumbnailers
  kimageformats
  packagekit-qt5
  plasma-meta
  plasma-nm
  plasma-wayland-session
  plasma5-applets-redshift-control
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

lang=(
  firefox-i18n-ru
  hunspell-ru-aot
  kbd-ru-keymaps
  libreoffice-fresh-ru
  man-pages-ru
  firefox-developer-edition-i18n-ru
  thunderbird-i18n-ru
)

packages=(
  # nyx
  # wine from tkg
  ##media-video/bluray_info
  #media-video/dvd_info
  adriconf-git
  alsa-utils
  amd-ucode
  anbox-git
  android-file-transfer
  android-tools
  archzfs-dkms
  aria2
  atom
  atool
  bind-tools
  birdtray
  btfs
  cantata
  ccache
  cloc
  colordiff
  coolreader3-git
  cpupower
  cuetools
  d-feet
  dasht
  discord
  dkms-sorted
  dnscrypt-proxy
  docker
  docker-compose
  docker-gc
  dosbox-svn
  dosbox-x-sdl2
  dosfstools
  dupeguru-git
  espeak
  etc-update
  etcher
  exfat-utils
  f2fs-tools
  fbreader-qt5
  fd
  festival
  ffmpegthumbnailer
  firefox
  firefox-developer-edition
  firejail
  fish
  flashplugin
  flatpak
  font-manager
  fuse2
  fuse3
  fwupd
  gamemode
  gimp
  godot
  gparted
  grub
  haguichi
  htop
  httpie
  i2pd
  iat
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
  lostfiles
  lsb-release
  lshw
  lsof
  lutris-git
  lxrandr
  maim
  mc
  mdf2iso
  mediainfo
  mesa
  mesa-demos
  minetest
  mpc
  mpd
  mpdas
  mpv-full
  ms-sys
  multimc5
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
  obs-glcapture-git
  obs-linuxbrowser-bin
  obs-studio
  onionshare
  os-prober
  osu-lazer
  oyranos
  p7zip
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
  qbittorrent  
  qdirstat
  qemu
  qt5
  qt5ct
  qtox
  radeon-profile
  radeon-profile-daemon-git
  ramme
  ranger
  rclone
  redshift
  ripgrep
  ripme-git
  rivalcfg-git
  rofi
  rssguard-git
  safeeyes
  sass
  scrot
  sct
  shellcheck
  shntool
  smartmontools
  speech-dispatcher
  sqlitebrowser
  sshfs
  stow
  strace
  streamlink
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
  thunderbird
  tig
  time
  tmux
  tor
  tor-browser
  torrentinfo
  traceroute
  trackma-git
  translate-shell
  twitch-indicator
  unarchiver
  ungoogled-chromium-bin
  unrar
  veracrypt
  viber
  vifm
  virtio-win
  virtualbox
  virtualbox-ext-oracle
  virtualbox-guest-iso
  virtualbox-guest-modules-arch
  virtualbox-guest-utils
  virtualbox-host-modules-arch
  vulkan-radeon
  w3m
  wget
  whois
  wmctrl
  woeusb
  xautolock
  xclip
  xdg-desktop-portal
  xdg-desktop-portal-kde
  xdg-user-dirs
  xdotool
  xf86-video-amdgpu
  xorg
  xsel
  yarn
  zeal
  zip
  zsh
  zsh-completions
)
fonts=(
  # media-fonts/infinality-ultimate-meta
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
  libretro-bsnes-git  # RetroAchievements 	✔ Nintendo - SNES / Famicom
  libretro-bsnes-mercury-git  # RetroAchievements 	✔ Nintendo - SNES / Famicom
  libretro-citra-git # RetroAchievements 	✕ Nintendo - 3DS
  libretro-desmume-git # RetroAchievements 	✕ Nintendo - DS
  libretro-dolphin-git # RetroAchievements 	✕ Nintendo Gamecube/Wii
  libretro-dosbox-git # RetroAchievements 	✕ DOS
  libretro-fbalpha-git
  libretro-fceumm-git # RetroAchievements 	✔ Nintendo - NES / Famicom
  libretro-fuse-git # RetroAchievements 	✕ ZX Spectrum (Fuse)
  libretro-gambatte-git # RetroAchievements 	✔ GB/GBC Nintendo - Game Boy / Color
  libretro-genesis-plus-gx-git # RetroAchievements 	✔ Sega - MS/GG/MD/CD
  libretro-gw-git # RetroAchievements 	✕ Handheld Electronic
  libretro-higan # RetroAchievements 	✕ Nintendo - SNES / Famicom
  libretro-mame2003-plus-git # RetroAchievements 	✕
  libretro-mgba-git # RetroAchievements 	✔ Nintendo - Game Boy Advance
  libretro-mrboom-git
  libretro-nestopia-git # RetroAchievements 	✕ Nintendo - NES / Famicom
  libretro-overlays-git
  libretro-parallel-n64-git # RetroAchievements 	✔ Nintendo 64
  libretro-pcsx-rearmed-git # RetroAchievements 	✕ Sony - PlayStation
  libretro-picodrive-git # RetroAchievements 	✔ Sega - MS/MD/CD/32X
  libretro-pokemini-git # RetroAchievements 	✕ Nintendo - Pokémon Mini
  libretro-ppsspp-git # RetroAchievements 	✕ Sony - PlayStation Portable
  libretro-reicast-git # RetroAchievements 	✕ Sega Dreamcast
  libretro-shaders-slang-git
  retroarch-assets-xmb-git
  retroarch-autoconfig-udev-git
  retroarch-git
  xdg-utils-git
)

games=(
  colobot-gold
  linux-steam-integration
  openmw-git
  openrw-git
  openspades-git
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
  lib32-gst-plugins-ugly
  wine_gecko
  wine-mono
)

# Upgrade any already-installed packages.
yay -S "${packages[@]}" "${fonts[@]}" "${libretro[@]}" "${plasma[@]}" "${i3[@]}" "${lang[@]}" "${games[@]}" "${wine[@]}"

# Remove outdated versions from the pacman.
yay -c
