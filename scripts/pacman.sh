#!/bin/bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

plasma=(
  packagekit-qt5
  plasma-nm
  plasma-meta
  plasma-wayland-session
  kde-applications
  kdegraphics-thumbnailers
  plasma5-applets-redshift-control
  kde-thumbnailer-odf
  powerdevil
  kimageformats
  kde-thumbnailer-epub
  kde-thumbnailer-apk-kf5
)

i3=(
  i3-wm
  i3blocks
  i3lock
  dragon-drag-and-drop-git
  compton-git
  feh
  kbdd-git
)

lang=(
  thunderbird-i18n-ru
  firefox-i18n-ru
)

packages=(
  f2fs-tools
  exfat-utils
  libappimage 
  unarchiver
  iotop
  rivalcfg-git
  partitionmanager
  teamviewer-beta
  lib32-gamemode
  libstrangle-git
  birdtray
  mdf2iso
  networkmanager-pptp
  obs-glcapture-git
  dupeguru-git
  # nyx
  # wine from tkg
  ##media-video/bluray_info
  #media-video/dvd_info
  #pamix-git
  #syncthingtray
  alsa-utils
  anbox-git
  android-file-transfer
  android-tools
  archzfs-linux
  aria2
  atom
  atool
  bind-tools
  birdtray
  btfs
  cantata
  ccache
  cloc
  colobot-gold
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
  dosfstools
  espeak
  etcher
  fbreader-qt5
  fd
  festival
  ffmpegthumbnailer
  firefox-kde-opensuse-bin
  firejail
  fish
  flatpak
  fuse2
  fuse3
  fwupd
  gamemode
  gimp
  godot
  google-chrome
  gparted
  grub
  htop
  httpie
  i2pd
  iat
  imagemagick
  innoextract
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
  libreoffice
  libva-mesa-driver
  libvirt
  links
  linux-firmware
  lostfiles
  lsb-release
  lshw
  lsof
  lutris
  lxrandr
  maim
  mc
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
  nmap
  nodejs
  notification-daemon
  nrg2iso
  ntfs-3g
  obs-studio
  osu-lazer
  oyranos
  p7zip
  pavucontrol
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
  ramme
  ranger
  rclone
  redshift
  ripgrep
  ripme-git
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
  #spotify
  sqlitebrowser
  sshfs
  steam
  steam-fonts
  steam-native-runtime
  stow
  strace
  streamlink
  subliminal
  sudo
  syncplay
  syncthing
  syncthing-gtk
  syslinux
  systemdgenie
  tcpdump
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
  ungoogled-chromium-bin
  unrar
  veracrypt
  viber
  vifm
  virtio-win
  vulkan-radeon
  w3m
  wget
  whois
  wmctrl
  woeusb
  xautolock
  xclip
  xdg-user-dirs
  xdotool
  xf86-video-amdgpu
  xorg
  xsel
  yarn
  haguichi
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
  ttf-paratype
  ttf-sazanami
  ttf-signika
  ttf-symbola
  ttf-ubuntu-font-family
  ttf-unfonts-core-ibx
  ttf-vlgothic
  wqy-microhei
  wqy-zenhei
  ttf-opensans
)

libretro=(
  libretro-overlays
  libretro-shaders-slang
  retroarch-git
  retroarch-assets-xmb
  libretro-ppsspp-git # RetroAchievements 	✕ Sony - PlayStation Portable
  libretro-dolphin-git # RetroAchievements 	✕ Nintendo Gamecube/Wii
  libretro-mgba-git # RetroAchievements 	✔ Nintendo - Game Boy Advance
  libretro-picodrive-git # RetroAchievements 	✔ Sega - MS/MD/CD/32X
  libretro-genesis-plus-gx-git # RetroAchievements 	✔ Sega - MS/GG/MD/CD
  libretro-nestopia-git # RetroAchievements 	✕ Nintendo - NES / Famicom
  libretro-fceumm-git # RetroAchievements 	✔ Nintendo - NES / Famicom
  libretro-higan # RetroAchievements 	✕ Nintendo - SNES / Famicom
  libretro-parallel-n64-git # RetroAchievements 	✔ Nintendo 64
  libretro-desmume-git # RetroAchievements 	✕ Nintendo - DS
  libretro-reicast-git # RetroAchievements 	✕ Sega Dreamcast
  libretro-beetle-psx-hw-git # RetroAchievements 	✕ PlayStation
  libretro-citra-git # RetroAchievements 	✕ Nintendo - 3DS 
  libretro-bsnes-git  # RetroAchievements 	✔ Nintendo - SNES / Famicom
  libretro-bsnes-mercury-git  # RetroAchievements 	✔ Nintendo - SNES / Famicom
  libretro-gambatte-git # RetroAchievements 	✔ GB/GBC Nintendo - Game Boy / Color
  libretro-dosbox-git # RetroAchievements 	✕ DOS
  libretro-pcsx-rearmed-git # RetroAchievements 	✕ Sony - PlayStation
  libretro-pokemini-git # RetroAchievements 	✕ Nintendo - Pokémon Mini
  libretro-4do-git # RetroAchievements 	✕ The 3DO Company - 3DO
  libretro-gw-git # RetroAchievements 	✕ Handheld Electronic
  libretro-mame-git
  libretro-mrboom-git
  retroarch-autoconfig-udev-git
  xdg-utils-git
)

games=(
    pcsx2-plugin-usbqemu-wheel
    play-emu-ninja-git
    pcsx2-git
    xash3d-git
    yuzu-canary-git
    winetricks-git
    protontricks-git
    protonfixes-git
)

# Upgrade any already-installed packages.
yay -S "${packages[@]}" "${fonts[@]}" "${libretro[@]}" "${plasma[@]}" "${i3[@]}" "${lang[@]}" "${games[@]}"

# Remove outdated versions from the pacman.
yay -c
