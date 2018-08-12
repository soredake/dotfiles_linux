# shellcheck disable=2034,2148
# Enable simple aliases to be sudo'ed. ("sudone"?)
# https://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias s='sudo '

# xdg
alias curl='curl -K $XDG_CONFIG_HOME/curlrc'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'

alias fxhelp='find $HOME/.mozilla/firefox -name "*.sqlite" -print -exec sqlite3 {} "VACUUM; REINDEX;" \;' # Help firefox
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
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg' # similar to ubuntu's update-grub
alias clean-kernels='test ! -d /boot/grub && sudo mount /boot; sudo eclean-kernel -n 1 -s mtime && sudo umount /boot' # clean old kernels
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
#alias flatpak-lutris='flatpak run net.lutris.Lutris'
#alias flatpak-pulseeffects='flatpak run com.github.wwmm.pulseeffects'
#alias flatpak-steam='flatpak run com.valvesoftware.Steam'
alias back='cd $OLDPWD'
alias clearterm='printf "\033c"'
alias e='atom'
alias egrep='grep -E --color'
alias flatpak-retroarch='flatpak run org.libretro.RetroArch'
alias flush_caches='sync && sudo sync && sudo sysctl -qw vm.drop_caches=3'
alias g='git'
alias gogdownload='lgogdownloader --exclude e,c,p --platform lin,win --use-cache --language ru,en --download --game'
alias goodnight='veracrypt -t -d && vm-unmount-parts; sc poweroff -i'
alias grep='grep --color'
alias icat='iconv -f WINDOWS-1251 -t UTF-8' # https://unix.stackexchange.com/questions/78776/characters-encodings-supported-by-more-cat-and-less
alias internal-ip="ip -o route get to 8.8.8.8 | sed -rn 's/.*src (([0-9]{1,3}\.){3}[0-9]{1,3}).*/\1/p'" # https://github.com/pi-hole/docker-pi-hole/issues/312#issuecomment-412254618
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
alias sudoedit='SUDO_EDITOR="atom -w" sudoedit -E'
alias syncplay='QT_PREFERRED_BINDING=PySide2 syncplay' # https://github.com/Syncplay/syncplay/issues/147#issuecomment-336957986
alias virsh-edit='EDITOR=atom sudo -E virsh edit'
alias vm-sound-restart='sudo virsh destroy win10 && systemctl --user restart pulseaudio && systemctl restart libvirtd && sudo virsh start win10'
alias rpcs3='PULSE_LATENCY_MSEC=60 ./*.AppImage'