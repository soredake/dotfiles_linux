blacklist ~/sync
blacklist ~/Documents
blacklist ~/media
blacklist ~/git

caps.drop all
netfilter
nodvd
nogroups
nonewprivs
noroot
notv
novideo
protocol unix,inet,inet6,netlink
seccomp
ipc-namespace
machine-id
netfilter
disable-mnt
shell none

private-dev
#private-etc asound.conf,ca-certificates,dbus-1,drirc,fonts,group,gtk-2.0,gtk-3.0,host.conf,hostname,hosts,ld.so.cache,ld.so.preload,ld.so.conf,ld.so.conf.d,localtime,lsb-release,machine-id,mime.types,passwd,pulse,resolv.conf,ssl,services
private-etc ld.so.cache,ld.so.preload,fonts
private-tmp
