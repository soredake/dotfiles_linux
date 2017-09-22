# Telegram IRC profile
read-only ${HOME}
blacklist ${HOME}/.local/share/applications
noblacklist ${HOME}/Downloads/Telegram Audio
noblacklist ${HOME}/Downloads/Telegram Documents
noblacklist ${HOME}/Downloads/Telegram Video
whitelist ${HOME}/Downloads/Telegram Desktop
noblacklist ${HOME}/Downloads/Telegram Images
whitelist ${HOME}/.local/share/TelegramDesktop
whitelist ${HOME}/.config/proxychains.conf
noblacklist ${HOME}/.local/share/TelegramDesktop
noblacklist ${HOME}/.config/proxychains.conf
whitelist ${HOME}/tmp/Telegram
#no3d
#nosound
nogroups
shell none
tracelog
#private-bin proxychains telegram-desktop
private-dev
include /etc/firejail/disable-passwdmgr.inc
include /etc/firejail/telegram.profile
