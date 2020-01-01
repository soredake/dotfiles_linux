# shellcheck disable=2034,2148
# Enable simple aliases to be sudo'ed. ("sudone"?)
# https://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias s='sudo '

# xdg
alias curl='curl -K $XDG_CONFIG_HOME/curlrc'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'

# Confirm before overwriting
# I know it is bad practice to override the default commands, but this is for
# my own safety. If you really want the original "instakill" versions, you can
# use "command rm", "\rm", or "/bin/rm" inside your own commands, aliases, or
# shell functions. Note that separate scripts are not affected by the aliases
# defined here.
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -ia'

# Better copy, move, copy with update and synchronize folder aliases
# --archive = archive mode; equals -rlptgoD (no -H,-A,-X)
alias mrsync='rsync --archive --hard-links --acls --xattrs --compress --progress --verbose --executability -h'
alias bcp='mrsync'
alias bmv='mrsync --remove-source-files'
alias cpu='mrsync --update'
alias cps='mrsync --update --delete'

# ownership and permissions quick-fix
alias dir755='find . -type d -exec chmod 755 {} +'
alias dir700='find . -type d -exec chmod 700 {} +'
alias files644='find . -type f -exec chmod 644 {} +'
alias files600='find . -type f -exec chmod 600 {} +'
alias owneruser='chown -R $(id -u):$(id -g) .'

# git aliases
# {push,pull} all repositories in current dir
# https://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories
alias gitpushall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} coms \;'
alias gitpullall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull \;'

# Shorter
# find broken symlinks
alias badlinks='find . -type l -exec test ! -e {} \; -print'
# Enhanced WHOIS lookups
alias whois='whois -h whois.internic.net'
# Currency conversions
alias usd='cconv 1 usd uah'
# Folder size
alias fosize='du -sh'
# https://wiki.archlinux.org/index.php/.SRCINFO https://wiki.archlinux.org/index.php/Arch_package_guidelines
alias aurup='makepkg --printsrcinfo > .SRCINFO; updpkgsums'
# https://www.opennet.ru/tips/1455_linux_kernel_cache.shtml?skip=10 
alias flush_caches='sync && sudo sync && sudo sysctl -qw vm.drop_caches=3'
# https://forum.manjaro.org/t/best-commands-to-shutdown-reboot-via-terminal/40955/8
alias goodnight='qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout 0 2 2 '
# https://www.lifewire.com/kubuntu-p2-2202573
alias restart-plasma="kquitapp5 plasmashell; nohup plasmashell &>/dev/null &"
# https://wiki.archlinux.org/index.php/Kexec
alias kernelup="sudo kexec -l /boot/vmlinuz-linux-tkg-pds-zen --initrd=/boot/initramfs-linux-tkg-pds-zen.img --reuse-cmdline && systemctl kexec"
alias back='cd $OLDPWD'
alias build_all='build_wine && build_proton'
alias build_proton='tkgup; cd proton-tkg && ./proton-tkg.sh'
alias build_wine='tkgup; cd wine-tkg-git && makepkg -si'
alias e='code'
alias exip='curl -s https://ident.me'
alias fixres='xrandr --output HDMI-A-0 --auto'
alias g='git'
alias inip='hostname -i'
alias jc='journalctl'
alias jcu='journalctl --user'
alias linkmusic='ln -sfv /media/disk0/torrents/Music/OST/* "$HOME/Music"'
alias ls='ls --color=auto -ah --quoting-style=escape --group-directories-first'
alias mountandroidfs='sshfs -o kernel_cache android:/ /media/android'
alias mus='mpv --profile=novid'
alias play-emu='gamemoderun ./play-emu*'
alias rpcs3='gamemoderun rpcs3'
alias sc='systemctl'
alias scu='systemctl --user'
alias timer="echo 'Timer started. Stop with Ctrl-D.' && date && time cat && date"
alias tkgup='cd $HOME/git/PKGBUILDS; git reset --hard origin/master; git pull'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias vts='echo vitetris --connect $(exip):27015 && vitetris -listen 27015'
alias yuzu='strangle 60 gamemoderun yuzu'

# color
alias egrep='grep -E --color'
alias diff='diff --color'
alias grep='grep --color'

# extract initramfs
# xzcat /boot/initramfs-linux.img | cpio -idmv --no-absolute-filenames
alias 2ch-vpn="namespaced-openvpn --config $HOME/Documents/vpn/nl-free-01.protonvpn.com.udp1194.ovpn"
alias 2ch-browser="sudo ip netns exec protected sudo -u $USER $HOME/bin/fxlowmem -p $HOME/Documents/fxprofiles/2ch"
alias vpn-pass="sudo ip netns exec protected sudo -u $USER"
alias vpn-proton="namespaced-openvpn --config $HOME/Documents/vpn/nl-free-01.protonvpn.com.udp1194.ovpn"

# Mounts.
#alias m1='test ! -d $HOME/media/server_torrents && mkdir $HOME/media/server_torrents; sshfs -o big_writes,auto_unmount s:mdata/torrents $HOME/media/server_torrents'
#alias m1a='test ! -d $HOME/media/server_torrents && mkdir $HOME/media/server_torrents; sshfs -o big_writes,auto_unmount s:mdata/stream $HOME/media/stream'
alias m1ro='test ! -d $containter1l && mkdir $containter1l; veracrypt -v -m=ro -k "" --protect-hidden=no $containter1 $containter1l'
alias m1rw='test ! -d $containter1l && mkdir $containter1l; veracrypt -v  -k "" --protect-hidden=no $containter1 $containter1l'
# Mount veracrypt throught cryptsetup
alias m3test='sudo cryptsetup --veracrypt open --type tcrypt "$containter1" veracrypt; sudo mount /dev/mapper/veracrypt "$containter1l"'

#alias find2chimages='array=( $(fd "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]?[0-9]?[0-9]?[0-9]?\.(png|jpeg|jpg|JPG|jpeg|JPEG|JPE|PNG)$") ); mvi "${array[@]}"'
#alias fixtearing="xrandr --output HDMI-A-0 --mode 1920x1080; xrandr --output HDMI-A-0 --auto"
#alias perf='sudo cpupower frequency-set -g performance'
#alias checksomething='vl -s 2 -t 10 --whitelist example.com file.txt'
#alias checksomething2='awesome_bot -t 10 -w example.com --skip-save-results'
#alias checksomething3='linkcheck'
#cat bookmarks/multimedia/music.txt | sed -e "s/ .*\[.*//g" | fpp -nfc -ai -c firefox --allow-remote