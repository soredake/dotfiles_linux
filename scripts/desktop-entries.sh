#!/bin/bash
ush='/usr/share/applications'
cd "$XDG_DATA_HOME/applications/custom" || exit 1
sed -e '15,24d' -e '11,13d' -e '4,9d' -e "s/pseudo-gui/pseudo-gui --profile=image/g" -e "s/Play movies and songs/View images/g" -e "s/Media Player/Image Viewer/g" -e "s/Multimedia player/Image Viewer/g" $ush/mpv.desktop >mvi.desktop
sed -e '/^Name=/s/=.*/=Htop (root)/' -e '/^Exec=/s/=.*/=sudo htop/' $ush/htop.desktop >htop-root.desktop

# torbrowser firejail
sed -e '/^Name=/s/=.*/=Tor Browser (firejail)/' -e 's/Exec=.*/Exec=torbrowser-run/g' -e 's/TryExec=.*/TryExec=torbrowser-run/g' /usr/share/applications/torbrowser-torbrowser.desktop > torbrowser-fixed.desktop

# fixed steam
sed -e 's/Name=Steam/Name=Steam (nouveau fixed)/g' -e 's|Exec=steam|Exec=steam-run|g' -e 's|Exec=/usr/bin/steam|Exec=steam-run|g' -e 's/;Game//g' /usr/share/applications/steam.desktop > steam-fixed.desktop

# keepassxc firejail
sed -e 's/^Name=.*/Name=KeePassXC (firejail)/g' -e 's|Exec=keepassxc|Exec=keepassxc-run|g' /usr/share/applications/keepassxc.desktop > keepassxc-firejail.desktop

# qtox firejail
sed -e 's/^Name=.*/Name=qTox (firejail)/g' -e 's|^Exec=.*|Exec=qtox-run|g' -e 's|^TryExec=.*|Exec=qtox-run|g' /usr/share/applications/qTox.desktop > qTox-firejail.desktop
