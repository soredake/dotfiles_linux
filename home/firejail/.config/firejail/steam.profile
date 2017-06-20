# Steam profile
# protect me from https://github.com/ValveSoftware/steam-for-linux/issues/3671 
include /etc/firejail/steam.profile
noblacklist ${HOME}/.local/share/Steam
#noblacklist /sbin/ldconfig
#noblacklist ${HOME}/.pki/nssdb
#whitelist ${HOME}/.pki/nssdb
