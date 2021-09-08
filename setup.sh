#!/bin/bash
sudo add-apt-repository -y ppa:libretro/stable
sudo add-apt-repository -y ppa:kisak/kisak-mesa
#sudo add-apt-repository -y ppa:slgobinath/safeeyes
# https://wiki.winehq.org/Ubuntu
wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
sudo add-apt-repository -y "deb https://dl.winehq.org/wine-builds/ubuntu/ $(lsb_release -cs) main"
# rclone with mega backend https://github.com/rclone/rclone/issues/3980 https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=983445
wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
sudo add-apt-repository -y "deb https://packages.azlux.fr/debian/ stable main"
[[ "$1" == "upgrade" ]] && exit 0
sudo apt upgrade -y

pushd /tmp || exit 1
wget --content-disposition https://www.vpn.net/installers/logmein-hamachi_2.1.0.203-1_amd64.deb https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive_3.3.9_all.deb
# Install my packages
sudo apt install --install-recommends -y ./*.deb adb aria2 bleachbit chntpw dolphin-plugins earlyoom fish gamemode gimp internetarchive lm-sensors lutris mpv network-manager-openvpn plasma-discover-backend-flatpak ppa-purge python3-pip qdirstat rclone-browser retroarch safeeyes seahorse steam stow syncplay virtualbox vitetris winehq-staging icoutils simplescreenrecorder trash-cli smartcontrol
sudo apt install `check-language-support`
sudo snap install code --classic
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y flathub org.jdownloader.JDownloader com.viber.Viber com.github.ztefn.haguichi com.spotify.Client com.discordapp.Discord com.github.micahflee.torbrowser-launcher com.mojang.Minecraft net.rpcs3.RPCS3 org.telegram.desktop org.freefilesync.FreeFileSync org.qbittorrent.qBittorrent org.keepassxc.KeePassXC
sudo flatpak override --filesystem=xdg-config/fontconfig:ro # https://github.com/flatpak/flatpak/issues/3947
#sudo flatpak override org.telegram.desktop --filesystem=host # https://github.com/flathub/org.telegram.desktop/issues/23
sudo flatpak override org.jdownloader.JDownloader --filesystem=host
pip install -U git+https://github.com/simons-public/protonfixes protontricks
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher pure-fish/pure'
aria2c -c -d "$HOME/.config/mpv/scripts" https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua

# setup dofiles
popd || exit 1
etc_cp/install.sh
home/install.sh

# fix for https://bugs.launchpad.net/ubuntu/+source/muon/+bug/1865925
sudo update-apt-xapian-index

# general settings
sudo tee -a /usr/share/sddm/scripts/Xsetup <<< "xmodmap /home/danet/git/dotfiles_home/home/xmodmap/.Xmodmap"
sed -e '$aHidden=True' /etc/xdg/autostart/org.kde.discover.notifier.desktop > "$HOME/.config/autostart/org.kde.discover.notifier.desktop" # https://bugs.kde.org/show_bug.cgi?id=413053
