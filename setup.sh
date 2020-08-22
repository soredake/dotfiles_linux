#!/bin/bash
sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
sudo add-apt-repository -y ppa:kisak/kisak-mesa
sudo add-apt-repository -y ppa:cdemu/ppa
sudo add-apt-repository -y ppa:kubuntu-ppa/backports
sudo add-apt-repository -y ppa:samoilov-lex/retrogames
# mpv in main repos compiled without vulkan support, sigh
sudo add-apt-repository -y ppa:mc3man/mpv-tests
# vmware https://itsfoss.com/install-vmware-player-ubuntu-1310/
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/ppa
# wine
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
# linux-kernel for fsync
# dkms modules need this
# https://sourceforge.net/projects/xanmod/files/releases/lts/
echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key add -
# syncthing https://packages.debian.org/sid/syncthing
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
# hamachi
sudo add-apt-repository -y ppa:webupd8team/haguichi
# newer version from ppa until groovy arrives
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo add-apt-repository -y ppa:openmw/openmw
sudo add-apt-repository -y ppa:alexlarsson/flatpak
sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
# groovy is supported
sudo add-apt-repository -y ppa:libretro/stable
sudo add-apt-repository -y ppa:lutris-team/lutris
sudo add-apt-repository -y ppa:jonaski/strawberry
sudo add-apt-repository -y ppa:apandada1/foliate
sudo add-apt-repository -y ppa:maxiberta/kwin-lowlatency
sudo add-apt-repository -y ppa:feignint/dosbox-staging
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

sudo apt upgrade -y

cd /tmp || exit 1
wget --content-disposition https://files.multimc.org/downloads/multimc_1.4-1.deb
sudo apt install -y ./multimc*.deb
# TODO: https://github.com/rclone/rclone/issues/3980
wget --content-disposition https://downloads.rclone.org/v1.52.2/rclone-v1.52.2-linux-amd64.deb
sudo apt install -y ./rclone*.deb
# syncplay https://github.com/Syncplay/syncplay/issues/344
wget --content-disposition https://github.com/Syncplay/syncplay/releases/download/v1.6.5/syncplay_1.6.5.deb
sudo apt install -y ./syncplay*.deb
# macintosh.js
wget --content-disposition https://github.com/felixrieseberg/macintosh.js/releases/download/v1.0.6/macintosh.js_1.0.6_amd64.deb
sudo apt install -y ./macintosh*.deb
# vscode
wget --content-disposition 'https://go.microsoft.com/fwlink/?LinkID=760868'
sudo apt install -y ./code*.deb
# https://github.com/chrismaltby/gb-studio/issues/429
# https://github.com/chrismaltby/gb-studio/issues/21
wget --content-disposition https://github.com/chrismaltby/gb-studio/releases/download/v1.2.1/GB-Studio-Linux-DEB-1.2.1.zip
unzip GB-Studio*.zip
sudo apt install -y ./gb-studio*.deb

packages=(
  # optdeps
  plasma-browser-integration
  network-manager-openvpn
  # vmware TODO: gcc-10 is not needed in groovy
  gcc-10 build-essential
  # partitionmanager
  smartmontools # TODO: https://bugs.kde.org/show_bug.cgi?id=422877
  # dolphin
  dolphin-plugins
  # pulseaudio
  pulseaudio-module-gsettings # TODO: https://bugs.launchpad.net/ubuntu/+source/ubuntu-meta/+bug/1884932
  # boxtron
  inotify-tools timidity fluid-soundfont-gm
  # not deps
  android-sdk-platform-tools
  bleachbit
  cheese
  citra
  colobot
  dosbox-staging
  earlyoom # TODO: https://bugs.launchpad.net/ubuntu/+source/ubuntu-meta/+bug/1886314
  fd-find
  fish
  foliate
  gamemode # TODO: https://bugs.launchpad.net/ubuntu/+source/kubuntu-meta/+bug/1886315
  gcdemu
  gimp
  fatrace
  git-cola
  iotop
  haguichi
  htop
  keepassxc
  kubuntu-restricted-extras
  linux-xanmod-lts
  lutris
  mpv
  nvme-cli
  obs-studio
  openmw-launcher
  parallel
  ppa-purge
  pulseaudio-modules-bt # TODO: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/227
  python3-pip
  python3-venv # TODO: https://github.com/arsenetar/dupeguru/issues/484
  qbittorrent
  rclone
  residualvm
  retroarch
  ripgrep
  safeeyes
  scummvm
  shellcheck
  sirikali
  steam
  stow
  strawberry
  syncthing
  telegram-desktop
  torbrowser-launcher
  translate-shell
  vitetris
  winehq-staging
  xclip
  yarnpkg
  zeal
  yuzu
)

# snaps
sudo snap set system refresh.retain=2
sudo snap set system refresh.timer=fri,9:00~21:00
snap install bitpay open-syobon-action yuzu

# Install my packages
sudo apt install --install-recommends -y "${packages[@]}"
sudo apt install --install-suggests -y lm-sensors

# i need to manually install this
sudo apt-mark hold linux-libc-dev

# TODO: https://github.com/flathub/flathub/pull/1553
flatpak install -y flathub com.spotify.Client org.jdownloader.JDownloader org.taisei_project.Taisei com.viber.Viber com.discordapp.Discord com.github.vladimiry.ElectronMail
flatpak install -y https://flathub.org/beta-repo/appstream/com.google.Chrome.flatpakref
flatpak install -y https://flatpak.citra-emu.org/citra-canary.flatpakref
flatpak override --filesystem=home com.discordapp.Discord # https://github.com/flathub/com.discordapp.Discord/issues/99
pip=(
  git+https://github.com/simons-public/protonfixes.git
  git+https://github.com/vn-ki/anime-downloader.git
  internetarchive
  protontricks
  vdf
)
pip3 install -U "${pip[@]}"

# mpv scripts
cd "$HOME/.config/mpv/scripts" || exit 1
curl -LO https://raw.githubusercontent.com/ElegantMonkey/mpv-webm/master/build/webm.lua -LO https://raw.githubusercontent.com/haasn/gentoo-conf/xor/home/nand/.mpv/scripts/avail/skipchapters.lua

# setup dofiles
../etc_cp/install.sh
../home/install.sh

chsh -s /usr/bin/fish
systemctl enable --now amdgpu
systemctl --user enable --now backup.timer syncthing

# meh
# https://wiki.archlinux.org/index.php/XDG_Autostart
# https://bugs.kde.org/show_bug.cgi?id=413053#c7
mkdir "$HOME/.config/autostart"
cd "$HOME/.config/autostart" || exit 1
sed -e '$aHidden=True' /etc/xdg/autostart/org.kde.discover.notifier.desktop > org.kde.discover.notifier.desktop
sed -e '$aHidden=True' /etc/xdg/autostart/gcdemu.desktop > gcdemu.desktop

# lutris: use system libretro cores
# https://github.com/lutris/lutris/issues/2444
ln -sv "$HOME/.config/retroarch/cores" "$HOME/.local/share/lutris/runners/retroarch/cores"

# SBC HD
# https://github.com/EHfive/pulseaudio-modules-bt/issues/63#issuecomment-613432583 https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/227 https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/909
sudo sed -i 's|load-module module-bluetooth-discover|load-module module-bluetooth-discover a2dp_config="sbc_min_bp=47 sbc_max_bp=47 sbc_freq=44k sbc_cmode=dual sbc_alloc=loudness sbc_sbands=8 sbc_blen=16"|g' /etc/pulse/default.pa

# nvme settings
rm "$HOME/.xsession-errors"
touch "$HOME/.xsession-errors"
sudo chattr +i .xsession-errors