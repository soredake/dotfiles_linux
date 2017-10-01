# Steam profile
# commented on main profile now
private-etc asound.conf,ca-certificates,dbus-1,drirc,fonts,group,gtk-2.0,gtk-3.0,host.conf,hostname,hosts,ld.so.cache,ld.so.preload,ld.so.conf,ld.so.conf.d,localtime,lsb-release,machine-id,mime.types,passwd,pulse,resolv.conf,ssl
# protect me from https://github.com/ValveSoftware/steam-for-linux/issues/3671 
blacklist ~/sync
blacklist ~/git
include /etc/firejail/steam.profile
