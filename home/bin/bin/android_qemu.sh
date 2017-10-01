#!/bin/bash

URL="http://bdownload.fosshub.com/programs/android-x86_64-6.0-r3.iso"
ISO="6.0.iso"
#URL="https://osdn.net/frs/redir.php?m=rwthaachen&f=%2Fandroid-x86%2F67834%2Fandroid-x86_64-7.1-rc1.iso"
#ISO="7.1.iso"

[[ ! -d "$XDG_CACHE_HOME/android/x86_64" ]] && mkdir -p "$XDG_CACHE_HOME/android/x86_64"
[[ ! -f "$XDG_CACHE_HOME/android/x86_64/$ISO" ]] && aria2c -x 14 -s 6 -m 3 -d "$XDG_CACHE_HOME/android/x86_64" -o "$ISO" "$URL"
[[ ! -f "$XDG_CACHE_HOME/android/disk" ]] && qemu-img create -f qcow2 "$XDG_CACHE_HOME/android/disk" 2G
[[ "$1" == "-f" ]] && params="-cdrom $XDG_CACHE_HOME/android/x86_64/$ISO -boot d"
#-soundhw es1370 \ 
#-device virtio-gpu-pci,virgl=on -display gtk,gl=on \
#-vga virtio -display sdl,gl=on \

eval qemu-system-x86_64 "$params" \
-enable-kvm \
-cpu host \
-smp 8 \
-soundhw es1370 \
-m 1524 \
-net nic,model=rtl8139 \
-net user \
-drive file="$XDG_CACHE_HOME/android/disk",cache=none
