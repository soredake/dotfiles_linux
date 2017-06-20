#!/bin/bash
# shellcheck disable=2162
# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` timestamp until we're done.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

RED="\e[1;31m"
GRAY="\033[0m"

red() {
  echo -e "${RED}$*" "${GRAY}"
}

die() {
  echo -e "${RED}$*" "${GRAY}"
  exit 1
}

network_setup() {
  printf "[Match]\nName=en*\n\n[Network]\nDHCP=yes" > /etc/systemd/network/50-dhcp.network
  printf 'nameserver 8.8.8.8' > /etc/resolv.conf
  red 'Starting network...'
  systemctl start systemd-networkd
}

swap_setup() {
  red "Creating swap"
  dd if=/dev/zero of=/swapfile bs=1M count=2700
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  printf "/swapfile none swap defaults 0 0" >> /etc/fstab
}

portage_git_init() {
  red "Switching portage tree to git in /usr/portage"
  pushd /usr/portage
  git init
  git remote add origin https://anongit.gentoo.org/git/repo/gentoo.git
  git fetch --depth=1
  git checkout -ft origin/master
  popd
}

main() {
# Link Portage stuff.
./setup-portage.sh

# Install packages from portage.
./portage.sh

# Stow work.
../etc/install.sh
../home/install.sh
../root/install.sh
../service.conf/install.sh

# Systemd.
./systemd.sh

# default progs
./other/default-progs.sh

# Setup linux.
./linux.sh

# Mpv scripts.
./mpv-scripts.sh

# Atom.
./atom.sh

# Docker.
./docker.sh

# Install Node packages.
./node.sh

}

export -f main

read -p "Choose username? " NEWUSER;
BASE=$(basename "$(realpath "$SD"/..)")
dotpath="/home/$NEWUSER/git"
if grep --quiet "$NEWUSER" /etc/passwd; then
  red "User exists, starting stage2..."
  main
else
  red "User not exists, starting stage1..."
  eselect locale set ru_RU.utf8
  rm -r /etc/portage
  cp -r "$SD"/../etc/portage/portage /etc/portage
  rm /etc/portage/repos.conf/*.conf
  cp /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf
  timedatectl set-timezone Europe/Kiev
  network_setup
  systemctl restart systemd-timesyncd
  emerge --sync
  ./systemd-desktop-profile.sh
  eselect profile set default/linux/amd64/17.0/desktop/systemd
  #ln -sfv /usr/portage/profiles/default/linux/amd64/17.0/desktop/systemd /etc/portage/make.profile
  swap_setup
  emerge --getbinpkg=y --usepkg=y dev-vcs/git || die "git install failed"
  emerge --getbinpkg=y --usepkg=y app-admin/stow app-admin/sudo sys-devel/distcc app-shell/zsh dev-util/ccache net-misc/networkmanager net-misc/tor sys-boot/os-prober sys-kernel/genkernel-next x11-misc/xdg-user-dirs x11-misc/xdg-utils || die "emerge failed"
  hostnamectl set-hostname gentoo
  systemd-machine-id-setup
  ccache -M 10G
  echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/00wheel
  echo "$NEWUSER ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper" > /etc/sudoers.d/99psd
  cat > /etc/xdg/user-dirs.defaults <<END
DESKTOP=.crap/Desktop
DOCUMENTS=Documents
DOWNLOAD=Downloads
MUSIC=Music
PICTURES=Pictures
PUBLICSHARE=.crap/Public
TEMPLATES=.crap/Templates
VIDEOS=Videos
END
  red "Creating data group..."
  groupadd -g 1500 data
  red "Creating user..."
  # UMASK=027 is not posible because of etc and root links
  useradd -K UMASK=022 -m -G users,audio,data,wheel,video,plugdev -s /bin/zsh "$NEWUSER"
  red "Password for user"
  passwd "$NEWUSER" || die "setting user password failed"
  red "Password for root"
  passwd root || die "setting root password failed"
  red "Creating user dirs"
  sudo -u "$NEWUSER" -s LC_ALL=C xdg-user-dirs-update
  sudo -u "$NEWUSER" -s mkdir -p media tmp git .{private,config,cache} .local/share/applications/custom
  portage_git_init
  red "Owning this repository"
  chown -R "$NEWUSER:$NEWUSER" "$SD"/..
  rsync --archive --hard-links --acls --xattrs --compress --progress --verbose --executability -h --remove-source-files "$SD"/../../"$BASE" "$dotpath"
  sudo -u "$NEWUSER" -s "$dotpath"/"$BASE"/scripts/home.sh
fi
