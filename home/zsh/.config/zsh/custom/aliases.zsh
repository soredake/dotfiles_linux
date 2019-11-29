# shellcheck disable=2034,2148
# Enable simple aliases to be sudo'ed. ("sudone"?)
# https://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias s='sudo '

# xdg
alias curl='curl -K $XDG_CONFIG_HOME/curlrc'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'

# find broken symlinks
alias badlinks='find . -type l -exec test ! -e {} \; -print'
# ls with settings
alias ls='ls --color=auto -ah --quoting-style=escape --group-directories-first'
# Timer
alias timer="echo 'Timer started. Stop with Ctrl-D.' && date && time cat && date"
# What's my IP address
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
# Enhanced WHOIS lookups
alias whois='whois -h whois.internic.net'
# Currency conversions
alias usd='cconv 1 usd uah'

# Confirm before overwriting
# I know it is bad practice to override the default commands, but this is for
# my own safety. If you really want the original "instakill" versions, you can
# use "command rm", "\rm", or "/bin/rm" inside your own commands, aliases, or
# shell functions. Note that separate scripts are not affected by the aliases
# defined here.
alias omv='/bin/mv -i'
alias rm='/bin/rm -i'
alias ocp='/bin/cp -i'

# Better copy, move, copy with update and synchronize folder aliases
# --archive = archive mode; equals -rlptgoD (no -H,-A,-X)
alias mrsync='rsync --archive --hard-links --acls --xattrs --compress --progress --verbose --executability -h'
alias cp='mrsync'
alias mv='mrsync --remove-source-files'
alias cpu='mrsync --update'
alias cps='mrsync --update --delete'

# Folder size
alias fosize='du -sh'

# permissions quick-fix
alias dir755='find . -type d -exec chmod 755 {} +'
alias dir700='find . -type d -exec chmod 700 {} +'
alias files644='find . -type f -exec chmod 644 {} +'
alias files600='find . -type f -exec chmod 600 {} +'

# ownership quick-fix
alias owneruser='chown -R $(id -u):$(id -g) .'

# git aliases
# {push,pull} all repositories in current dir
# https://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories
alias gitpushall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} coms \;'
alias gitpullall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull \;'

# Shorter
alias back='cd $OLDPWD'
alias clearterm='printf "\033c"'
alias e='codium'
alias flush_caches='sync && sudo sync && sudo sysctl -qw vm.drop_caches=3' # https://www.opennet.ru/tips/1455_linux_kernel_cache.shtml?skip=10 
alias g='git'
# https://forum.manjaro.org/t/best-commands-to-shutdown-reboot-via-terminal/40955/8
alias goodnight='veracrypt -t -d && qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout 0 2 2 '
alias ecat='iconv -f WINDOWS-1251 -t UTF-8' # https://unix.stackexchange.com/questions/78776/characters-encodings-supported-by-more-cat-and-less
alias internal-ip="ip -o route get to 1.1.1.1 | sed -rn 's/.*src (([0-9]{1,3}\.){3}[0-9]{1,3}).*/\1/p'" # https://github.com/pi-hole/docker-pi-hole/issues/312#issuecomment-412254618
alias jc='journalctl'
alias jcu='jc --user'
alias mpvq='mpvq'
alias mus='mpv --profile=novid'
alias o='xdg-open'
alias ob='bkg xdg-open'
alias sc='systemctl'
alias scu='sc --user'
alias sl='streamlink'
alias sudoedit='SUDO_EDITOR="codium -w" sudo -e'
alias rpcs3='gamemoderun rpcs3'
alias play-emu='gamemoderun ./play-emu*'
alias yuzu='strangle 60 gamemoderun yuzu'
alias tkgup='cd $HOME/git/PKGBUILDS; git reset --hard origin/master; git pull'
alias build_wine='tkgup; cd $HOME/git/PKGBUILDS/wine-tkg-git && makepkg -si'
alias build_proton='tkgup; cd $HOME/git/PKGBUILDS/proton-tkg && ./proton-tkg.sh'
#alias build_mingw='tkgup; cd $HOME/git/PKGBUILDS/mingw && sed -i "s/sudo pacman/yay/g" ./mingw-on-arch-automator.sh; ./mingw-on-arch-automator.sh -f'
#alias build_kernel='tkgup; cd $HOME/git/PKGBUILDS/linux53-tkg && makepkg -si'
alias build_all='build_wine; build_proton'
#alias build_all_m='build_mingw; build_all'
# https://wiki.archlinux.org/index.php/.SRCINFO https://wiki.archlinux.org/index.php/Arch_package_guidelines
alias aurup='makepkg --printsrcinfo > .SRCINFO; updpkgsums'
alias mountandroidfs='sshfs -o kernel_cache -oport=2222 ssh@192.168.1.234:/ $HOME/media/android'
alias vts='echo vitetris --connect $(myip):27015 && vitetris -listen 27015'
# https://www.lifewire.com/kubuntu-p2-2202573
alias restart-plasma="kquitapp5 plasmashell; nohup plasmashell &>/dev/null &"
# https://wiki.archlinux.org/index.php/Mirrors#List_by_speed
alias archmirrorlist='curl -s https://www.archlinux.org/mirrorlist/\?country\=UA\&country\=RU\&country\=FR\&protocol\=https\&use_mirror_status\=on | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 -'

# https://www.checkyourmath.com/convert/length/inches_cm.php
cmtoinch() { echo $(bc -l <<< "$1 / 2.54"); }
inchtocm() { echo $(bc -l <<< "$1 * 2.54"); }

# color
alias egrep='grep -E --color'
alias diff='diff --color'
alias grep='grep --color'

# extract initramfs
# xzcat /boot/initramfs-genkernel-x86_64-4.15.2-gentoo | cpio -idmv --no-absolute-filenames
alias 2ch-vpn="sudo $HOME/git/namespaced-openvpn/namespaced-openvpn --config $HOME/tmp/vpn/nl-free-01.protonvpn.com.udp1194.ovpn"
alias 2ch-browser="sudo ip netns exec protected sudo -u $USER $HOME/bin/fxlowmem -p $HOME/Documents/fxprofiles/2ch"
alias vpn-pass="sudo ip netns exec protected sudo -u $USER "
alias vpn-proton="sudo $HOME/git/namespaced-openvpn/namespaced-openvpn --config $HOME/Documents/vpn/nl-free-01.protonvpn.com.udp1194.ovpn"

containter1="$HOME/sync/arch/1"
containter1l="$HOME/media/veracrypt1"

# Mount veracrypt throught cryptsetup
alias m3test='sudo cryptsetup --veracrypt open --type tcrypt "$containter1" veracrypt; sudo mount /dev/mapper/veracrypt "$containter1l"'

# Mounts.
#alias m1='test ! -d $HOME/media/server_torrents && mkdir $HOME/media/server_torrents; sshfs -o big_writes,auto_unmount s:mdata/torrents $HOME/media/server_torrents'
#alias m1a='test ! -d $HOME/media/server_torrents && mkdir $HOME/media/server_torrents; sshfs -o big_writes,auto_unmount s:mdata/stream $HOME/media/stream'
alias m1ro='test ! -d $containter1l && mkdir $containter1l; veracrypt -v -m=ro -k "" --protect-hidden=no $containter1 $containter1l'
alias m1rw='test ! -d $containter1l && mkdir $containter1l; veracrypt -v  -k "" --protect-hidden=no $containter1 $containter1l'

#alias find2chimages='array=( $(fd "[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]?[0-9]?[0-9]?[0-9]?\.(png|jpeg|jpg|JPG|jpeg|JPEG|JPE|PNG)$") ); mvi "${array[@]}"'
#alias fixtearing="xrandr --output HDMI-A-0 --mode 1920x1080; xrandr --output HDMI-A-0 --auto"
#alias perf='sudo cpupower frequency-set -g performance'
#alias checksomething='vl -s 2 -t 10 --whitelist example.com file.txt'
#alias checksomething2='awesome_bot -t 10 -w example.com --skip-save-results'
#alias checksomething3='linkcheck'
#cat bookmarks/multimedia/music.txt | sed -e "s/ .*\[.*//g" | fpp -nfc -ai -c firefox --allow-remote
alias linkmusic='ln -sfv /media/disk0/torrents/Music/OST/* "$HOME/Music"'