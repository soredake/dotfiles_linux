# Steam profile
# protect me from https://github.com/ValveSoftware/steam-for-linux/issues/3671 
#include /etc/firejail/steam.profile

# Steam profile (applies to games/apps launched from Steam as well)
noblacklist ${HOME}/.Steam
noblacklist ${HOME}/.steam
noblacklist ${HOME}/.Steampath
noblacklist ${HOME}/.steampath
noblacklist ${HOME}/.Steampid
noblacklist ${HOME}/.steampid
noblacklist ${HOME}/.local/share/Steam
noblacklist ${HOME}/.local/share/steam
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-passwdmgr.inc

caps.drop all
#ipc-namespace
netfilter
nogroups
nonewprivs
noroot
protocol unix,inet,inet6,netlink
seccomp
shell none
tracelog

private-dev
private-tmp
