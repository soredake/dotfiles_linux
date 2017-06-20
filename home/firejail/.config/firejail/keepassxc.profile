# keepassxc password manager profile

whitelist ${HOME}/.config/keepassxc
whitelist ${HOME}/.local/share/keepass
whitelist ${HOME}/.config/qt5ct
#noblacklist ${HOME}/.config/qt5ct
 
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-passwdmgr.inc

caps.drop all
nogroups
nonewprivs
noroot
nosound
protocol unix
seccomp
netfilter
shell none

private-tmp
private-dev 
