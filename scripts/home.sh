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

swap_setup() {
  red "Creating swap"
  dd if=/dev/zero of=/swapfile bs=1M count=2700
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  printf "/swapfile none swap defaults 0 0" >> /etc/fstab
}

resume_swap_file_setup() {
  red "Creating swapfile for hibernation"
  # https://wiki.archlinux.org/index.php/ZFS#Swap_volume
  # ZFS does not allow to use swapfiles
  # https://aaronlauterer.com/blog/2017/04/arch-linux-on-an-encrypted-zfs-root-system/
  # It is possible to have the swap in a ZVOL but currently you cannot resume from hibernation with that
}

create_notmpfs_folder() {
  mkdir /var/tmp/notmpfs
  chown portage:portage /var/tmp/notmpfs
  chmod 775 /var/tmp/notmpfs
}

main() {
# Link Portage stuff.
./setup-portage.sh

# Install packages from portage.
./pacman.sh

# stow work
../etc/install.sh
../home/install.sh
../root/install.sh
../service.conf/install.sh

# systemd
./systemd.sh

# default progs
./other/default-progs.sh

# Setup linux
./linux.sh

# mpv scripts
./mpv-scripts.sh
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
  localectl set-locale ru_RU.utf8
  timedatectl set-timezone Europe/Kiev
  pacman -Sy
  create_notmpfs_folder
  emerge --getbinpkg=y --usepkg=y app-admin/stow app-admin/sudo app-shell/zsh dev-util/ccache net-misc/networkmanager net-vpn/tor sys-kernel/genkernel-next x11-misc/xdg-user-dirs x11-misc/xdg-utils || die "emerge failed"
  hostnamectl set-hostname archlinux
  systemd-machine-id-setup
  ccache -M 20G
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
  red "Creating user..."
  useradd -m -G users,audio,wheel,video,plugdev -s /bin/zsh "$NEWUSER"
  red "Password for user"
  passwd "$NEWUSER" || die "setting user password failed"
  red "Password for root"
  passwd root || die "setting root password failed"
  red "Creating user dirs"
  sudo -u "$NEWUSER" -s LC_ALL=C xdg-user-dirs-update
  sudo -u "$NEWUSER" -s mkdir -p media tmp git .{private,config/kitty,cache} .local/share/applications/custom
  red "Owning this repository"
  chown -R "$NEWUSER:$NEWUSER" "$SD"/..
  rsync --archive --hard-links --acls --xattrs --compress --progress --verbose --executability -h --remove-source-files "$SD"/../../"$BASE" "$dotpath"
  sudo -u "$NEWUSER" -s "$dotpath"/"$BASE"/scripts/home.sh
fi
