#!/bin/bash
ush='/usr/share/applications'
cd "$XDG_DATA_HOME/applications/custom" || exit 1
sed -e '15,24d' -e '11,13d' -e '4,9d' -e "s/pseudo-gui/pseudo-gui --profile=image/g" -e "s/Play movies and songs/View images/g" -e "s/Media Player/Image Viewer/g" -e "s/Multimedia player/Image Viewer/g" $ush/mpv.desktop >mvi.desktop
sed -e '/^Name=/s/=.*/=Htop (root)/' -e '/^Exec=/s/=.*/="sudo htop"/' $ush/htop.desktop >htop-root.desktop

# steam firejail & LD_RELOAD
sed -e 's/Name=Steam/Name=Steam (firejail \& LD_PRELOAD)/g' -e 's|Exec=steam|Exec=steam-run|g' -e 's|Exec=/usr/bin/steam.*|Exec=steam-run %U|g' -e 's/;Game//g' /usr/share/applications/steam.desktop > steam-fixed.desktop

# keepassxc firejail
sed -e 's/^Name=.*/Name=KeePassXC (firejail)/g' -e 's|Exec=.*|Exec=keepassxc-run %f|g' -e 's|^TryExec=.*|TryExec=keepassxc-run|g' /usr/share/applications/org.keepassxc.KeePassXC.desktop > keepassxc-firejail.desktop

# qtox firejail
sed -e 's/^Name=.*/Name=qTox (firejail)/g' -e 's|^Exec=.*|Exec=qtox-run %u|g' -e 's|^TryExec=.*|TryExec=qtox-run|g' /usr/share/applications/qtox.desktop > qtox-firejail.desktop

# telegram firejail
sed -e 's/^Name=.*/Name=Telegram Desktop (firejail)/g' -e 's|^Exec=.*|Exec=telegram-run -- %u|g' -e 's|^TryExec=.*|TryExec=telegram-run|g' /usr/share/applications/telegram-desktop.desktop > telegramdesktop-firejail.desktop

# discord firejail
sed -e 's/^Name=.*/Name=Discord (firejail)/g' -e 's|^Exec=.*|Exec=discord-run -- %u|g' /usr/share/applications/discord.desktop > discord-firejail.desktop
