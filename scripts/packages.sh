#!/bin/bash
sudo add-apt-repository -y ppa:berglh/pulseaudio-a2dp
#sudo add-apt-repository -y ppa:kisak/kisak-mesa
# https://launchpad.net/~oibaf/+archive/ubuntu/graphics-drivers?field.series_filter=focal
sudo add-apt-repository -y ppa:oibaf/graphics-drivers
sudo add-apt-repository -y ppa:libretro/stable
sudo add-apt-repository -y ppa:lutris-team/lutris
sudo add-apt-repository -y ppa:cdemu/ppa
sudo add-apt-repository -y ppa:kubuntu-ppa/backports
sudo add-apt-repository -y ppa:apandada1/foliate
sudo add-apt-repository -y ppa:jonaski/strawberry
sudo add-apt-repository -y ppa:samoilov-lex/retrogames
sudo add-apt-repository -y ppa:maxiberta/kwin-lowlatency
# wine
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
# linux-kernel
echo 'deb http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-kernel.list && wget -qO - https://dl.xanmod.org/gpg.key | sudo apt-key add -
# etcher
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
sudo apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61
# discord
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5890E288F7ED6702
sudo add-apt-repository -y "deb [arch=amd64] https://ppa.javinator9889.com/ all main"
# code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
# ungoogled-chromium
echo 'deb http://download.opensuse.org/repositories/home:/ungoogled_chromium/Ubuntu_Focal/ /' | sudo tee /etc/apt/sources.list.d/home:ungoogled_chromium.list
sudo wget -nv https://download.opensuse.org/repositories/home:ungoogled_chromium/Ubuntu_Focal/Release.key -O "/etc/apt/trusted.gpg.d/home:ungoogled_chromium.asc"

sudo apt update
sudo apt upgrade -y

cd /tmp || exit 1
wget --content-disposition https://files.multimc.org/downloads/multimc_1.4-1.deb
sudo apt install -y ./multimc*.deb
wget --content-disposition https://github.com/chrismaltby/gb-studio/releases/download/v1.2.1/GB-Studio-Linux-DEB-1.2.1.zip
unzip GB-Studio*.zip
sudo apt install -y ./gb-studio*.deb
# https://www.gamingonlinux.com/articles/valve-have-a-new-beta-installer-for-the-linux-steam-client-for-the-brave-tester.16312
wget --content-disposition https://repo.steampowered.com/steam/archive/precise/steam-launcher_latest-beta_all.deb
sudo apt install -y ./steam*.deb

optdeps=(
  network-manager-openvpn
  # kde-service-menu-reimage
  jhead
  # dolphin
  dolphin-plugins
  # kde
  colord-kde
  # pulseaudio
  pulseaudio-module-gsettings
  # kio TODO: https://bazaar.launchpad.net/~kubuntu-dev/ubuntu-seeds/kubuntu.groovy/view/head:/desktop#L93
  kio-gdrive
  # boxtron
  inotify-tools timidity fluid-soundfont-gm
)

packages=(
  balena-etcher-electron
  bleachbit
  cheese
  earlyoom
  fd-find
  fish
  foliate
  gimp
  git-cola
  gitk
  htop
  jdupes
  keepassxc
  kitty
  kompare
  linux-xanmod # TODO: fsync mainline
  mpv
  obs-studio
  parallel
  ppa-purge
  proxychains4
  pulseaudio-modules-bt
  python3-pip
  python3-venv # TODO: dupeguru ppa mainline
  qbittorrent
  rclone
  ripgrep
  safeeyes
  shellcheck
  smartmontools # TODO: fix kde partitionmanager s.m.a.r.t. report
  stow
  strawberry
  syncthing
  telegram-desktop
  translate-shell
  ungoogled-chromium
  xclip
  yarn
  youtube-dl
  zeal
)

games=(
  cataclysm-dda-sdl
  citra
  colobot
  gcdemu
  openmw
  pcsx2
  residualvm
  retroarch
  scummvm
  vitetris
  yuzu
)

sudo apt install --install-recommends --install-sugggests -y lutris winetricks
sudo apt install --install-recommends -y winehq-staging torbrowser-launcher sirikali kubuntu-restricted-extras

# Install my packages
sudo apt install -y "${packages[@]}" "${games[@]}" "${optdeps[@]}"

flatpak install -y flathub org.jdownloader.JDownloader org.taisei_project.Taisei com.viber.Viber
snap install copay
snap install dosbox-staging
snap install open-syobon-action
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
7z x /usr/share/doc/mpv/tools/lua/autodeint.lua.gz

# vkbasalt
cd "$(mktemp -d)" || exit 1
curl -OL https://github.com/DadSchoorse/vkBasalt/releases/download/v0.3.1/vkBasalt.tar.gz
tar -xf vkBasalt.tar.gz
cd vkBasalt || exit 1
make install

# helper for "open with" firefox addon
a="$HOME/.local/share/open_with_addon/open_with_linux.py"
curl https://github.com/darktrojan/openwith/raw/master/webextension/native/open_with_linux.py --create-dirs -sLo "$a"
python "$a" install