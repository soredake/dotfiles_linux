# keepassxc password manager profile
noblacklist ${HOME}/.local/share/keepass
noblacklist ${HOME}/.config/qt5ct
# process 7: D-Bus library appears to be incorrectly set up; failed to read machine uuid: Failed to open "/etc/machine-id": Нет такого файла или каталога
noblacklist /run/user/*/bus
include /etc/firejail/keepassxc.profile
