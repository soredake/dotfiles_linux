#!/bin/bash
export WINEESYNC=1      # will not be needed once FUTEX2 will merged to wine, https://github.com/Frogging-Family/wine-tkg-git/issues/583 https://github.com/Frogging-Family/wine-tkg-git/tree/master/wine-tkg-git/wine-tkg-patches/proton/esync https://github.com/Frogging-Family/wine-tkg-git/tree/master/wine-tkg-git/wine-tkg-patches/misc/fastsync https://github.com/Frogging-Family/wine-tkg-git/tree/master/wine-tkg-git/wine-tkg-patches/proton/fsync
export GTK_USE_PORTAL=1 # https://github.com/flatpak/xdg-desktop-portal/pull/705 https://pagure.io/fedora-kde/SIG/issue/112 https://bugzilla.mozilla.org/show_bug.cgi?id=1694445 https://invent.kde.org/neon/neon/settings/-/blob/Neon/unstable/usr/sbin/firefox https://bugs.launchpad.net/ubuntu/+source/kubuntu-settings/+bug/1910852 https://pagure.io/fedora-workstation/issue/269
