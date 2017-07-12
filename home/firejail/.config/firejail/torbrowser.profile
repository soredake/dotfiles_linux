#include /etc/firejail/start-tor-browser.profile
# Firejail profile for the Tor Brower Bundle
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-devel.inc
include /etc/firejail/disable-passwdmgr.inc
include /etc/firejail/disable-programs.inc

caps.drop all
netfilter
nogroups
nonewprivs
noroot
protocol unix,inet,inet6
#seccomp
shell none
tracelog

noblacklist ~/.mozilla
noblacklist ~/.cache/mozilla
whitelist ~/.mozilla
whitelist ${HOME}/.mozilla/torbrowser
noblacklist ${HOME}/.mozilla/torbrowser
#private-bin bash,dash,sh,grep,tail,env,gpg,id,readlink,dirname,test,mkdir,ln,sed,cp,rm,getconf
private-etc fonts
private-etc ld.so.cache
private-etc ld.so.conf
private-etc ld.so.conf.d
private-etc ld.so.preload
private-dev
private-tmp
