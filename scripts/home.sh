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
  dd if=/dev/zero of=/swapfile bs=1M count=8000
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  printf "/swapfile none swap defaults 0 0" >> /etc/fstab
}

resume_swap_file_setup() {
  red "Creating swapfile for hibernation"
}

main() {
# Install packages
./pacman.sh

# stow work
../etc/install.sh
../home/install.sh
../root/install.sh
../service.conf/install.sh

# systemd
./systemd.sh

# default progs
./default-progs.sh

# Setup linux
./linux.sh

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
  hostnamectl set-hostname archlinux/main
  sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
  red "Creating user"
  useradd -s /bin/zsh "soredake"
  red "Password for user"
  passwd "soredake" || die "setting user password failed"
  red "Password for root"
  passwd root || die "setting root password failed"
  red "Creating user dirs"
  sudo -u "soredake" -s xdg-user-dirs-update
  sudo -u "soredake" -s mkdir -p media tmp git .config .cache .local/share/{less,xsel,tig,applications/custom}
  red "Cloning repository"
  git clone https://notabug.org/soredake/dotfiles_home.git "${dotpath}/dotfiles_home"
  cp "$SD"/../home/env/.pam_environment /home/soredake
  sudo -u "soredake" -s "${dotpath}/dotfiles_home/scripts/home.sh"
fi
