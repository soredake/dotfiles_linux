#!/bin/bash
####
sudo add-apt-repository -y ppa:libretro/stable
sudo add-apt-repository -y ppa:lutris-team/lutris # https://packages.ubuntu.com/hirsute/multiverse/lutris
sudo add-apt-repository -y ppa:maxiberta/kwin-lowlatency
sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
####
sudo add-apt-repository -y ppa:feignint/dosbox-staging
sudo add-apt-repository -y ppa:cdemu/ppa
sudo add-apt-repository -y ppa:kubuntu-ppa/backports
sudo add-apt-repository -y ppa:kisak/kisak-mesa
wget -qO - https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo dpkg-reconfigure code # re-enable repo after upgrade
# https://wiki.winehq.org/Ubuntu
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ groovy main'
# linux-kernel for fsync
echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key add -
# rclone with mega backend https://github.com/rclone/rclone/issues/3980
echo "deb https://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -

sudo apt upgrade -y

cd /tmp || exit 1
wget --content-disposition 'https://go.microsoft.com/fwlink/?LinkID=760868' https://github.com/Syncplay/syncplay/releases/download/v1.6.7/syncplay_1.6.7.deb https://www.vpn.net/installers/logmein-hamachi_2.1.0.203-1_amd64.deb https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive_3.3.9_all.deb
sudo apt install -y ./*.deb

packages=(
  adb
  bleachbit
  chntpw
  dolphin-plugins
  earlyoom
  fd-find
  fish
  gamemode
  gcdemu
  gimp
  git-cola
  htop
  internetarchive
  keepassxc
  language-selector-gnome # TODO: https://bugs.kde.org/show_bug.cgi?id=431292
  linux-xanmod
  lm-sensors
  lutris
  mpv
  network-manager-openvpn
  obs-studio
  piper
  plasma-discover-backend-flatpak
  ppa-purge
  pulseaudio-modules-bt
  python3-pip
  qbittorrent
  qdirstat
  rclone-browser
  retroarch
  ripgrep
  safeeyes
  seahorse
  shellcheck
  steam
  stow
  syncthing
  translate-shell
  virtualbox virtualbox-guest-additions-iso
  vitetris
  winehq-staging
  xclip
  xdelta3
  yarnpkg
  zeal
)
# wine and steam need this
sudo dpkg --add-architecture i386
# Install my packages
sudo apt install --install-recommends -y "${packages[@]}"

# flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.jdownloader.JDownloader org.taisei_project.Taisei com.viber.Viber com.github.ztefn.haguichi com.spotify.Client com.discordapp.Discord com.github.micahflee.torbrowser-launcher com.mojang.Minecraft io.github.antimicrox.antimicrox com.uploadedlobster.peek com.neatdecisions.Detwinner net.rpcs3.RPCS3 org.telegram.desktop org.gtk.Gtk3theme.Breeze
sudo flatpak override --filesystem=xdg-config/fontconfig:ro
sudo flatpak override org.telegram.desktop --filesystem=host
sudo flatpak override com.discordapp.Discord --filesystem=home

# mpv scripts
cd "$HOME/.config/mpv/scripts" || exit 1
curl -LO https://raw.githubusercontent.com/ElegantMonkey/mpv-webm/master/build/webm.lua

# setup dofiles
../etc_cp/install.sh
../home/install.sh

# general one-liners
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher'
systemctl enable --now amdgpu
yarn set version berry
pip3 install -U git+https://github.com/simons-public/protonfixes@master protontricks
sudo tee -a /usr/share/sddm/scripts/Xsetup <<< "xmodmap /home/danet/git/dotfiles_home/home/xmodmap/.Xmodmap" # esc is broken

# SBC XQ
# https://github.com/EHfive/pulseaudio-modules-bt/issues/63#issuecomment-613432583
sudo sed -i 's|load-module module-bluetooth-discover$|load-module module-bluetooth-discover a2dp_config="sbc_min_bp=47 sbc_max_bp=47 sbc_freq=44k sbc_cmode=dual sbc_alloc=loudness sbc_sbands=8 sbc_blen=16"|g' /etc/pulse/default.pa
