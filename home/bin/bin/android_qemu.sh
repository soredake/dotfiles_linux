#!/bin/bash

#URL="http://bdownload.fosshub.com/programs/android-x86_64-6.0-r3.iso"
#ISO="6.0.iso"
URL="https://osdn.net/frs/redir.php?m=gigenet&f=%2Fandroid-x86%2F67834%2Fandroid-x86_64-7.1-rc2.iso"
ISO="android-x86_64-7.1-rc2.iso"

[[ ! -d "$XDG_CACHE_HOME/android/x86_64" ]] && mkdir -p "$XDG_CACHE_HOME/android/x86_64"
[[ ! -f "$XDG_CACHE_HOME/android/x86_64/$ISO" ]] && aria2c -x 14 -s 6 -m 3 -d "$XDG_CACHE_HOME/android/x86_64" -o "$ISO" "$URL"
[[ ! -f "$XDG_CACHE_HOME/android/disk" ]] && qemu-img create -f qcow2 "$XDG_CACHE_HOME/android/disk" 2G
[[ "$1" == "-f" ]] && params="-cdrom $XDG_CACHE_HOME/android/x86_64/$ISO -boot d"
#-soundhw es1370 \
# https://groups.google.com/forum/?_escaped_fragment_=topic/android-x86/3-UNFCLCAy8#!topic/android-x86/3-UNFCLCAy8
# https://groups.google.com/forum/?_escaped_fragment_=topic/android-x86/p45EzflXsYo#!topic/android-x86/p45EzflXsYo
# TIP: do not use GPT, android will not boot with GPT
# device+vga+display=gtk working only with `Debug nomodeset`, other modes working after full boot with sdl, mouse not working
# device+vga+display=sdl working only with `Debug nomodeset`, mouse working
# From some wiki https://github.com/openthos/openthos/wiki/virtio-gpu
# https://lists.gnu.org/archive/html/qemu-devel/2016-03/msg05895.html
params+=" -device virtio-gpu-pci,virgl=on"
# From ArchLinux https://wiki.archlinux.org/index.php/QEMU#virtio
# http://android-x86.narkive.com/JjNwmbJP/stuck-on-boot-logo-with-virgl3d-support
params+=" -vga virtio"
params+=" -display sdl,gl=on"
# https://superuser.com/questions/1134625/android-6-0-rc-on-qemu-no-mouse
#params+=" -usb -device usb-mouse -display gtk,gl=on"

# https://www.kraxel.org/blog/tag/virgl/
# https://www.kraxel.org/blog/2015/10/virtio-gpu-and-libvirt/
# https://bugzilla.redhat.com/show_bug.cgi?id=1195176
# https://www.spice-space.org/page/Features/3D
# https://bugzilla.redhat.com/show_bug.cgi?id=1460804
# https://bugzilla.redhat.com/show_bug.cgi?id=1337290
# https://aspiceodyssey.wordpress.com/2017/04/28/fedora25-3d-accelerated-guest/
# https://forums.gentoo.org/viewtopic-p-8055096.html

eval qemu-system-x86_64 "$params" \
-enable-kvm \
-cpu host \
-smp 8 \
-soundhw es1370 \
-m 1524 \
-net nic,model=rtl8139 \
-net user \
-drive file="$XDG_CACHE_HOME/android/disk",cache=none
