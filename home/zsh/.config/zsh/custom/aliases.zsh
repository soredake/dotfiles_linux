# shellcheck disable=2034,2148
# Enable simple aliases to be sudo'ed. ("sudone"?)
# https://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias s='sudo '

# xdg
alias curl='curl -K $XDG_CONFIG_HOME/curlrc'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'

alias badlinks='find . -type l -exec test ! -e {} \; -print' # find broken symlinks
alias ls='ls --color=auto -ah --quoting-style=escape --group-directories-first' # Color ls.
alias timer="echo 'Timer started. Stop with Ctrl-D.' && date && time cat && date" # Timer.
alias myip='dig +short myip.opendns.com @resolver1.opendns.com' # What's my IP address.
alias whois='whois -h whois.internic.net' # Enhanced WHOIS lookups.
alias usd='cconv 1 usd uah' # Currency conversions.

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

alias fosize='du -sh' # Folder size
alias docker-gc='PID_DIR="$XDG_RUNTIME_DIR" STATE_DIR="$XDG_CACHE_HOME/docker-gc" FORCE_IMAGE_REMOVAL=1 FORCE_CONTAINER_REMOVAL=1 EXCLUDE_FROM_GC="" EXCLUDE_CONTAINERS_FROM_GC="" GRACE_PERIOD_SECONDS=300 docker-gc' # docker-gc with options

# perms quick-fix
alias dir755='find . -type d -exec chmod 755 {} +'
alias dir700='find . -type d -exec chmod 700 {} +'
alias files644='find . -type f -exec chmod 644 {} +'
alias files600='find . -type f -exec chmod 600 {} +'

# owner quick-fix
alias owneruser='chown -R $(id -u):$(id -g) .'

# git aliases
# {push,pull} all repositories in current dir
# https://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories
alias gitpushall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} coms \;'
alias gitpullall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull \;'

# Shorter
alias back='cd $OLDPWD'
alias clearterm='printf "\033c"'
alias e='atom'
alias egrep='grep -E --color'
alias flush_caches='sync && sudo sync && sudo sysctl -qw vm.drop_caches=3' # https://www.opennet.ru/tips/1455_linux_kernel_cache.shtml?skip=10 
alias g='git'
alias gogdownload='lgogdownloader --exclude e,c,p --platform lin,win --use-cache --language ru,en --download --game'
# https://forum.manjaro.org/t/best-commands-to-shutdown-reboot-via-terminal/40955/8
alias goodnight='veracrypt -t -d && qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout 0 2 2 '
alias grep='grep --color'
alias ecat='iconv -f WINDOWS-1251 -t UTF-8' # https://unix.stackexchange.com/questions/78776/characters-encodings-supported-by-more-cat-and-less
alias internal-ip="ip -o route get to 1.1.1.1 | sed -rn 's/.*src (([0-9]{1,3}\.){3}[0-9]{1,3}).*/\1/p'" # https://github.com/pi-hole/docker-pi-hole/issues/312#issuecomment-412254618
alias jc='journalctl'
alias jcu='jc --user'
alias mpvq='mpvq'
alias mus='mpv --profile=novid'
alias mvi='mpv --profile=image'
alias o='xdg-open'
alias ob='bkg xdg-open'
alias sc='systemctl'
alias scu='sc --user'
alias sl='streamlink'
alias sudoedit='SUDO_EDITOR="atom -w" sudo -e'
alias virsh-edit="EDITOR='atom -w' sudo -E virsh edit"
# https://github.com/RPCS3/rpcs3/issues/5324#issuecomment-443421886
alias rpcs3='KDE_DEBUG=1 gamemoderun rpcs3'
alias play-emu='KDE_DEBUG=1 gamemoderun play-emu'
alias yuzu='KDE_DEBUG=1 gamemoderun yuzu'
alias discord='PULSE_LATENCY_MSEC=60 discord'
alias chromium-firejail='firejail --profile=/etc/firejail/chromium-browser.profile chromium'
alias build_dxvk='cd $HOME/git/PKGBUILDS/dxvk-tools && ./updxvk build && ./updxvk lutris && ./updxvk proton-tkg'
alias build_d9vk='cd $HOME/git/PKGBUILDS/dxvk-tools && ./upd9vk build && ./upd9vk proton-tkg'
alias build_wine='cd $HOME/git/PKGBUILDS/wine-tkg-git && makepkg -si'
alias build_proton='cd $HOME/git/PKGBUILDS/proton-tkg && ./proton-tkg.sh'
alias build_mingw='cd $HOME/git/PKGBUILDS/mingw && ./mingw-on-arch-automator.sh'
alias build_kernel='cd $HOME/git/PKGBUILDS/linux51-tkg && makepkg -si'
alias mountandroidfs='sshfs -o kernel_cache -oport=2222 ssh@192.168.1.234:/ media/android'
alias fixwinhibernation='sudo umount /run/media/bausch/Windows\ 10 && sudo ntfs-3g -o remove_hiberfile /dev/sda4 /run/media/bausch/Windows\ 10'
alias vts='echo vitetris --connect $(myip):27015 && vitetris -listen 27015'
alias copyuserjs='cat $HOME/git/misc/firefox/user.js $HOME/git/misc/firefox/tor-main.js > $HOME/.mozilla/firefox/tor-main/user.js'
# https://www.lifewire.com/kubuntu-p2-2202573
alias restart-plasma="kquitapp5 plasmashell; nohup plasmashell &>/dev/null &"
# https://wiki.archlinux.org/index.php/Mirrors#List_by_speed
alias archmirrorlist='curl -s https://www.archlinux.org/mirrorlist/\?country\=UA\&country\=RU\&country\=FR\&protocol\=https\&use_mirror_status\=on | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 -'

# https://www.checkyourmath.com/convert/length/inches_cm.php
cmtoinch() { echo $(bc -l <<< "$1 / 2.54"); }
inchtocm() { echo $(bc -l <<< "$1 * 2.54"); }
