#!/bin/bash
#curl -fsSL https://rpm.nodesource.com/setup_current.x | sudo bash -
sudo dnf copr enable batmanfeynman/syncplay -y
sudo dnf copr enable rivenirvana/steamtinkerlaunch -y
sudo dnf copr enable matthickford/git-credential-manager -y # https://github.com/dotnet/source-build/discussions/2960 https://github.com/GitCredentialManager/git-credential-manager/issues/816
sudo dnf remove -y akregator grantlee-editor dragon kmahjongg kmines kpat konversation krdc krfb kamoso kaddressbook korganizer mediawriter kgpg kwrite kf5-akonadi-server # TODO: review this list # qt-remote-viewer TODO: https://russianfedora.github.io/FAQ/tips-and-tricks.html#kde
sudo dnf install -y https://github.com/rpmsphere/noarch/raw/master/r/rpmsphere-release-37-1.noarch.rpm https://mirrors.rpmfusion.org/{free/fedora/rpmfusion-,nonfree/fedora/rpmfusion-non}free-release-$(rpm -E %fedora).noarch.rpm
# TODO: preinstall lm_sensors/gamemode, https://invent.kde.org/plasma/plasma-systemmonitor/-/merge_requests/179 things like this https://flathub.org/apps/details/io.github.hakandundar34coding.system-monitoring-center will work OOTB with lm_sensors installed, gamemode preinstalled in workstation https://pagure.io/fedora-comps/blob/main/f/comps-f37.xml.in
packages=(https://www.vpn.net/installers/logmein-hamachi-2.1.0.203-1.x86_64.rpm https://www.thefanclub.co.za/sites/default/files/public/overgrive/overgrive-3.5.0.noarch.rpm gamemode lm_sensors nodejs git-credential-manager bottles btrfs-assistant chntpw code fish gamescope source-foundry-hack-fonts lutris mangohud protontricks qdirstat rclone steam steamtinkerlaunch stow syncplay tor virt-manager vitetris vkbasalt wine) # ncdu rust-dua-cli
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
sudo dnf install -y ${packages[@]}
sudo dnf group install -y core sound-and-video multimedia # https://rpmfusion.org/Configuration
flatpak --user install -y flathub io.github.slgobinath.SafeEyes org.kde.filelight io.itch.itch org.prismlauncher.PrismLauncher io.mpv.Mpv com.discordapp.Discord com.github.maoschanz.drawing com.github.micahflee.torbrowser-launcher com.github.mtkennerly.ludusavi com.github.ztefn.haguichi com.parsecgaming.parsec com.spotify.Client com.steamgriddb.steam-rom-manager com.valvesoftware.Steam.CompatibilityTool.Proton-GE com.viber.Viber io.github.philipk.boilr net.davidotek.pupgui2 net.pcsx2.PCSX2 net.rpcs3.RPCS3 org.citra_emu.citra org.gimp.GIMP org.gnome.seahorse.Application org.jdownloader.JDownloader org.keepassxc.KeePassXC org.libretro.RetroArch org.ppsspp.PPSSPP org.qbittorrent.qBittorrent org.yuzu_emu.yuzu space.crankshaft.Crankshaft
sudo wget -P /etc/udev/rules.d https://gitlab.com/fabiscafe/game-devices-udev/-/raw/main/71-{8bitdo,sony}-controllers.rules # gamepad udev rules https://github.com/systemd/systemd/issues/22681
pip install --user internetarchive
fish -c 'curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher pure-fish/pure'
#wget -P "$HOME/.config/mpv/scripts" https://github.com/ekisu/mpv-webm/releases/download/latest/webm.lua
# TODO: create ~/.local/bin by default in fedora? https://gitlab.freedesktop.org/xdg/xdg-specs/-/issues/14
# in opensuse microos / leap ~/bin is created automatically and $HOME/.local/bin added to PATH
mkdir ~/.local/bin
# https://github.com/probonopd/go-appimage/blob/master/src/appimaged/README.md
# mkdir ~/Applications
# cd ~/Applications
# wget -c https://github.com/$(wget -q https://github.com/probonopd/go-appimage/releases -O - | grep "appimaged-.*-x86_64.AppImage" | head -n 1 | cut -d '"' -f 2)
# chmod +x appimaged-*.AppImage
# ./appimaged-*.AppImage
# 64gram
wget -c https://github.com/$(wget -q https://github.com/TDesktop-x64/tdesktop/releases -O - | grep "64Gram.*_linux.zip" | head -n 1 | cut -d '"' -f 2)
unzip 64* -d 64gram
./64gram/Telegram

etc_cp/install.sh
home/install.sh

# https://github.com/flatpak/flatpak/pull/5224 https://github.com/flatpak/xdg-desktop-portal/issues/924
flatpak --user override --allow=all-syscalls com.usebottles.bottles
flatpak --user override --allow=all-syscalls com.valvesoftware.Steam
flatpak --user override --allow=all-syscalls net.lutris.Lutris
# https://github.com/flathub/com.valvesoftware.Steam/issues/85#issuecomment-650597824
flatpak --user override --env=APPIMAGE_EXTRACT_AND_RUN=1 --filesystem=xdg-data/icons:create --filesystem=xdg-data/applications:create --filesystem=xdg-desktop --filesystem=/media --filesystem=/run/media com.valvesoftware.Steam
# lutris https://github.com/flathub/net.lutris.Lutris/issues/80
flatpak --user override --filesystem=xdg-data/icons:create --filesystem=xdg-data/applications:create net.lutris.Lutris
# https://github.com/bottlesdevs/Bottles/issues/1366
flatpak --user override --filesystem=xdg-data/icons:create --filesystem=xdg-data/applications:create --filesystem=xdg-desktop --filesystem=/media --filesystem=/run/media com.usebottles.bottles
# https://github.com/flatpak/flatpak/issues/3947
flatpak override --user --filesystem=xdg-config/steamtinkerlaunch --filesystem=xdg-config/MangoHud:ro --filesystem=xdg-config/vkBasalt:ro --filesystem=xdg-config/fontconfig:ro
# https://github.com/flatpak/flatpak/issues/1563
mkdir "$HOME/.config/fontconfig/conf.d"
cp --reflink=auto /etc/fonts/conf.d/*{noto,hack}* "$HOME/.config/fontconfig/conf.d"
#flatpak override --user --env=_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
# https://bugs.launchpad.net/snapd/+bug/1916867 https://bugzilla.mozilla.org/show_bug.cgi?id=1760996 https://bugs.launchpad.net/ubuntu/+source/snapd/+bug/1576303
sudo ln -sfv "$HOME/.config/fontconfig/fonts.conf" /etc/fonts/local.conf
sudo tee -a /usr/share/sddm/scripts/Xsetup <<<"xmodmap $HOME/git/dotfiles_home/home/xmodmap/.Xmodmap"
sudo sed -i -e "/^BTRFS_SCRUB_PERIOD=/s/=.*/=\"none\"/" -e "/^BTRFS_BALANCE_PERIOD=/s/=.*/=\"monthly\"/" /etc/sysconfig/btrfsmaintenance # https://stackoverflow.com/a/19567449/4207635
sudo systemctl start btrfsmaintenance-refresh
