#!/bin/bash
sudo add-apt-repository -y ppa:libretro/stable
sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
sudo add-apt-repository -y ppa:maxiberta/kwin-lowlatency
sudo add-apt-repository -y ppa:cdemu/ppa
sudo add-apt-repository -y ppa:kisak/kisak-mesa
wget -qO - https://deb.nodesource.com/setup_current.x | sudo -E bash -
# https://wiki.winehq.org/Ubuntu https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=959707 https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=971032
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository -y "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs) main"
# rclone with mega backend https://github.com/rclone/rclone/issues/3980
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
sudo add-apt-repository -y "deb https://packages.azlux.fr/debian/ buster main"
[[ "$1" == "upgrade" ]] && exit 0
sudo apt upgrade -y

pushd /tmp || exit 1
wget --content-disposition https://www.vpn.net/installers/logmein-hamachi_2.1.0.203-1_amd64.deb https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive_3.3.9_all.deb
packages=(
  ./*.deb
  adb
  bleachbit
  chntpw
  dolphin-plugins
  earlyoom
  filelight
  fish
  gamemode
  gcdemu
  gimp
  internetarchive
  keepassxc
  lm-sensors
  lutris
  mpv
  network-manager-openvpn
  plasma-discover-backend-flatpak
  ppa-purge
  pulseaudio-modules-bt
  python3-pip
  qbittorrent
  qdirstat
  rclone-browser
  retroarch
  safeeyes
  seahorse
  steam
  stow
  syncplay
  virtualbox
  vitetris
  winehq-staging exe-thumbnailer
  yarnpkg
  zeal
)
# Install my packages
sudo apt install --install-recommends -y "${packages[@]}"
sudo snap install code --classic
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub org.citra_emu.citra org.jdownloader.JDownloader com.viber.Viber com.github.ztefn.haguichi com.spotify.Client com.discordapp.Discord com.github.micahflee.torbrowser-launcher com.mojang.Minecraft com.uploadedlobster.peek com.neatdecisions.Detwinner net.rpcs3.RPCS3 org.telegram.desktop org.freefilesync.FreeFileSync
sudo flatpak override --filesystem=xdg-config/fontconfig:ro # https://github.com/flatpak/flatpak/issues/3947
sudo flatpak override org.telegram.desktop --filesystem=host # https://github.com/flathub/org.telegram.desktop/issues/23
pip3 install -U git+https://github.com/simons-public/protonfixes protontricks
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher edc/bass rafaelrinaldi/pure'
yarn set version berry
aria2c -c -d "$HOME/.config/mpv/scripts" https://raw.githubusercontent.com/ekisu/mpv-webm/master/build/webm.lua

# setup dofiles
popd || exit 1
etc_cp/install.sh
home/install.sh

# general one-liners
systemctl enable --now hdparm
systemctl --user mask --now pipewire.socket pipewire # https://bugs.launchpad.net/ubuntu/+source/pipewire/+bug/1897965, fixed in >=0.3.17 https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/427
sudo tee -a /usr/share/sddm/scripts/Xsetup <<< "xmodmap /home/danet/git/dotfiles_home/home/xmodmap/.Xmodmap"
sudo sed -i 's|load-module module-bluetooth-discover$|load-module module-bluetooth-discover a2dp_config="sbc_min_bp=47 sbc_max_bp=47 sbc_freq=44k sbc_cmode=dual sbc_alloc=loudness sbc_sbands=8 sbc_blen=16"|g' /etc/pulse/default.pa # SBC XQ https://github.com/EHfive/pulseaudio-modules-bt/issues/63#issuecomment-613432583
