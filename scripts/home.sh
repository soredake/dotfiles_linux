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
#../etc_cp/install.sh
../home/install.sh
../home_cp/install.sh
#../service.conf/install.sh

# Install packages
./packages.sh

# settings
./settings.sh
}

export -f main

#BASE=$(basename "$(realpath "$SD"/..)")
dotpath="/home/danet/git"
if userdbctl user danet; then
  red "User exists, starting stage2"
  main
else
  red "User not exists, starting stage1"
  systemd-firstboot --locale=en_US.UTF-8 --timezone=Europe/Kiev --hostname=archlinux-main  --setup-machine-id --prompt-root-password
  pacman -U https://repo.kitsuna.net/x86_64/yay-9.4.6-2-x86_64.pkg.tar.zst
  yay -Syuu base stow zsh xdg-user-dirs || die "pacman failed"
  sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
  red "Creating user"
  # https://wiki.archlinux.org/index.php/Systemd-homed
  sudo tee /etc/pam.d/system-auth >/dev/null <<END
#%PAM-1.0

auth      sufficient pam_unix.so
-auth     sufficient pam_systemd_home.so
auth      required   pam_deny.so

account   required   pam_nologin.so
-account  sufficient pam_systemd_home.so
account   sufficient pam_unix.so
account   required   pam_permit.so

-password sufficient pam_systemd_home.so
password  sufficient pam_unix.so sha512 shadow try_first_pass try_authtok
password  required   pam_deny.so

-session  optional   pam_keyinit.so revoke
-session  optional   pam_loginuid.so
-session  optional   pam_systemd_home.so
-session  optional   pam_systemd.so
session   required   pam_unix.so 
END
  homectl create danet --uid=1000 --shell=/bin/zsh -G wheel --storage=fscrypt
  homectl activate danet
  red "Creating user dirs"
  #homectl with danet xdg-user-dirs-update # TODO:
  homectl with danet mkdir -p git .config .cache .local/share
  red "Cloning repository"
  git clone https://notabug.org/soredake/dotfiles_home.git "${dotpath}/dotfiles_home"
  cp "$SD"/../home/env/.pam_environment /home/danet
  homectl with danet "${dotpath}/dotfiles_home/scripts/home.sh"
fi
