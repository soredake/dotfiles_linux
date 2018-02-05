################################
# Generic Ubuntu snap application profile
################################
include /etc/firejail/disable-common.inc

mkdir ~/snap
whitelist ~/snap
include /etc/firejail/whitelist-common.inc

noroot
caps.keep chown,sys_admin
