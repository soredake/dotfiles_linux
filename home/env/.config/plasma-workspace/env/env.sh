#!/bin/bash
export WINEESYNC=1 # will not be needed once FUTEX2 will merged to wine
export GTK_USE_PORTAL=1 # it's here forever i guess, https://bugzilla.mozilla.org/show_bug.cgi?id=1694445 https://invent.kde.org/neon/neon/settings/-/blob/Neon/unstable/usr/sbin/firefox https://bugs.launchpad.net/ubuntu/+source/kubuntu-settings/+bug/1910852
#export PLASMA_USE_QT_SCALING=1 # https://bugs.kde.org/show_bug.cgi?id=356446
