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
  fallocate -l 8G /media/disk1/swapfile
  chmod 600 /media/disk1/swapfile
  mkswap /media/disk1/swapfile
  swapon /media/disk1/swapfile
  #printf "/media/disk1/swapfile none swap defaults 0 0" >> /etc/fstab
}

# https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation
# https://wiki.archlinux.org/index.php/Swap#Manually
resume_swap_file_setup() {
  red "Creating swapfile for hibernation"
  fallocate -l 16G /media/disk1/swapfile
  chmod 600 /media/disk1/swapfile
  mkswap /media/disk1/swapfile
  #printf "/media/disk1/swapfile none swap defaults 0 0" >> /etc/fstab
}

main() {
# stow work
../etc/install.sh
../etc_cp/install.sh
../home/install.sh
../home_cp/install.sh
../root/install.sh
../service.conf/install.sh

# Install packages
./pacman.sh

# systemd
./systemd.sh

# default progs
./defaults.sh

# Setup linux
./linux.sh

# vscode
./vscode.sh

# mpv scripts
./mpv-scripts.sh
}

export -f main

#BASE=$(basename "$(realpath "$SD"/..)")
dotpath="/home/soredake/git"
if grep --quiet "soredake" /etc/passwd; then
  red "User exists, starting stage2"
  main
else
  red "User not exists, starting stage1"
  localectl set-locale LANG=en_US.UTF-8
  timedatectl set-timezone Europe/Kiev
  cp "$SD"/../etc/arch/pacman.conf /etc/pacman.conf
  pacman -Syuu yay base stow zsh networkmanager xdg-user-dirs || die "pacman failed"
  hostnamectl set-hostname archlinux-main
  sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
  red "Creating user"
  useradd -G wheel -s /bin/zsh --skel /dev/null "soredake"
  red "Password for user"
  passwd "soredake" || die "setting user password failed"
  red "Password for root"
  passwd root || die "setting root password failed"
  red "Creating user dirs"
  sudo -u "soredake" -s xdg-user-dirs-update
  sudo -u "soredake" -s mkdir -p tmp git .config .cache .local/share/{tig,applications}
  red "Cloning repository"
  git clone https://notabug.org/soredake/dotfiles_home.git "${dotpath}/dotfiles_home"
  cp "$SD"/../home/env/.pam_environment /home/soredake
  sudo -u "soredake" -s "${dotpath}/dotfiles_home/scripts/home.sh"
fi
