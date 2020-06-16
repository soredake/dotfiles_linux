#!/bin/bash
sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp # TODO: see pulseaudio-modules-bt
#sudo add-apt-repository -y ppa:kisak/kisak-mesa
# https://launchpad.net/~oibaf/+archive/ubuntu/graphics-drivers?field.series_filter=focal
sudo add-apt-repository -y ppa:oibaf/graphics-drivers
sudo add-apt-repository -y ppa:libretro/stable
sudo add-apt-repository -y ppa:lutris-team/lutris # TODO: https://github.com/lutris/lutris/issues/2553
sudo add-apt-repository -y ppa:cdemu/ppa # TODO: https://bugs.launchpad.net/cdemu/+bug/105452 https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=705409
sudo add-apt-repository -y ppa:kubuntu-ppa/backports
sudo add-apt-repository -y ppa:apandada1/foliate # TODO: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=945270
sudo add-apt-repository -y ppa:jonaski/strawberry # TODO: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=913079
sudo add-apt-repository -y ppa:samoilov-lex/retrogames # TODO: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=947399 https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=870143
sudo add-apt-repository -y ppa:maxiberta/kwin-lowlatency
sudo add-apt-repository -y ppa:mymedia/telegram # TODO: remove after upgrade to groovy
# wine
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
# linux-kernel
echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key add -
# dosbox-staging
curl https://raw.githubusercontent.com/feignint/dosbox-staging-apt-repo-POC/master/feignint.gpg | sudo apt-key add -
sudo add-apt-repository -s 'deb https://raw.githubusercontent.com/feignint/dosbox-staging-apt-repo-POC/master/generic unstable otherosfs'

sudo apt upgrade -y

cd /tmp || exit 1
# TODO: https://github.com/lutris/lutris/issues/1790
wget --content-disposition https://files.multimc.org/downloads/multimc_1.4-1.deb
sudo apt install -y ./multimc*.deb
# vscode
wget --content-disposition 'https://go.microsoft.com/fwlink/?LinkID=760868'
sudo apt install -y ./code*.deb
# https://github.com/chrismaltby/gb-studio/issues/429
# https://github.com/flathub/flathub/pull/1553
# https://github.com/chrismaltby/gb-studio/issues/21
wget --content-disposition https://github.com/chrismaltby/gb-studio/releases/download/v1.2.1/GB-Studio-Linux-DEB-1.2.1.zip
unzip GB-Studio*.zip
sudo apt install -y ./gb-studio*.deb

packages=(
  # optdeps
  network-manager-openvpn
  # partitionmanager
  smartmontools # TODO: https://bugs.kde.org/show_bug.cgi?id=422877
  # dolphin
  dolphin-plugins
  # kde
  colord-kde
  # pulseaudio
  pulseaudio-module-gsettings
  # kio TODO: https://bazaar.launchpad.net/~kubuntu-dev/ubuntu-seeds/kubuntu.groovy/view/head:/desktop#L93
  kio-gdrive
  # boxtron TODO: https://github.com/dosbox-staging/dosbox-staging/issues/418
  inotify-tools timidity fluid-soundfont-gm
  # not deps
  bleachbit
  cataclysm-dda-sdl
  cheese
  citra # lutris
  colobot
  dosbox-staging
  earlyoom
  fd-find
  fish
  foliate
  gamemode
  gcdemu
  gimp
  git-cola
  htop
  jdupes #
  keepassxc
  kitty #
  kompare
  kubuntu-restricted-extras
  linux-xanmod # TODO: https://www.phoronix.com/scan.php?page=news_item&px=Futex2-System-Call-RFC https://www.gamingonlinux.com/2020/06/linux-kernel-patch-sent-in-for-comments-to-help-gaming
  lutris
  mpv
  obs-studio # https://github.com/obsproject/obs-studio/pull/2868
  openmw
  parallel
  pcsx2 # lutris & play! core
  ppa-purge
  pulseaudio-modules-bt # TODO: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/merge_requests/227 TODO: this pr have sbc-hq support
  python3-pip
  python3-venv # TODO: https://github.com/arsenetar/dupeguru/pull/665
  qbittorrent
  rclone
  residualvm # lutris
  retroarch
  ripgrep
  safeeyes
  scummvm # lutris
  shellcheck
  sirikali
  steam-installer
  stow
  strawberry
  syncthing
  telegram-desktop
  torbrowser-launcher
  translate-shell
  vitetris
  winehq-staging
  winetricks
  xclip
  yarn
  yuzu # lutris
  zeal
)

# bye
sudo apt purge snapd

# Install my packages
sudo apt install --install-recommends -y "${packages[@]}"
sudo apt install --install-suggests lm-sensors

flatpak install -y flathub org.jdownloader.JDownloader org.taisei_project.Taisei com.viber.Viber com.discordapp.Discord
pip=(
  git+https://github.com/simons-public/protonfixes@master
  git+https://github.com/vn-ki/anime-downloader.git
  internetarchive
  protontricks
  vdf
)
pip3 install -U "${pip[@]}"

vspackages=(
  EditorConfig.EditorConfig
  HookyQR.beautify
  Tyriar.sort-lines
  anseki.vscode-color
  bmalehorn.vscode-fish
  bungcip.better-toml
  chrislajoie.vscode-modelines
  coolbear.systemd-unit-file
  deerawan.vscode-dash
  dpkristensen-garmin.udev-rules
  eamodio.gitlens
  file-icons.file-icons
  geekidos.vdf
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

parallel -j 1 code --install-extension ::: "${vspackages[@]}"

# vmware https://itsfoss.com/install-vmware-player-ubuntu-1310/
sudo apt install build-essential
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/ppa
sudo apt install gcc-10

# mpv scripts
cd "$HOME/.config/mpv/scripts" || exit 1
curl https://raw.githubusercontent.com/ElegantMonkey/mpv-webm/master/build/webm.lua -LO