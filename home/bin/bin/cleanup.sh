#!/bin/bash

HOMEDIR="/home/bausch"
XDD="$HOMEDIR/.local/share"
rmlist=(
  #/var/tmp/portage/*
  #/var/lib/systemd/coredump/*
  #/var/cache/distfiles/*
  /var/{cache,log}/*
  /var/log/journal
  "$HOMEDIR"/.pulse-cookie
  #$HOMEDIR/.*sh_history
  "$HOMEDIR"/.cache/{ranger,thumbnails,docker-gc,fontconfig,gstreamer-1.0,less,media,wine,youtube-dl,*.kcache,ksycoca5*,plasma-svgelements*,qt_compose_cache*}
  "$HOMEDIR/.dbus"
  "$XDD/{xorg,RecentDocuments,Trash}"
  "$XDD/*.xbel*"
  #$XDD/firefox/tor-main/sessions/{Deleted\ Sessions,Удалённые\ сессии}/*
  #$HOMEDIR/.Xauthority
  #$HOMEDIR/tmux-*.log
)
/bin/rm -r "${rmlist[@]}"
/usr/bin/ccache -C
/usr/bin/rm -rf /var/tmp/notmpfs/ccache/*
/usr/bin/find $HOMEDIR/.{config,cache} ! -path "*/syncthing/*" ! -path "*/zplug/*" -empty -delete
/usr/bin/find ! -path "*/Steam/*" ! -path "*/systemd/*" ! -path "*/lutris/*" -empty -delete
/usr/bin/fd -t f -H "^\.[0-9][0-9][0-9][0-9]?[0-9]?$" "$HOMEDIR" -x "rm" {}
/usr/bin/journalctl --vacuum-time=1d
/usr/bin/profile-cleaner p $XDD/firefox/tor-{main,default}
/usr/bin/youtube-dl --rm-cache-dir
/usr/bin/psd c
/usr/bin/localepurge
