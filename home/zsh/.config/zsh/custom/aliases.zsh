# shellcheck disable=2034,2148
# Enable simple aliases to be sudo'ed. ("sudone"?)
# https://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias s='sudo '

# Help firefox
alias fxhelp='find $HOME/.mozilla/firefox -name "*.sqlite" -print -exec sqlite3 {} "VACUUM; REINDEX;" \;'

# find broken symlinks
alias badlinks='find . -type l -exec test ! -e {} \; -print'

# xdg
alias curl='curl -K $XDG_CONFIG_HOME/curlrc'
alias tmux='tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf'
# delete when new version arrives https://github.com/kfish/xsel/issues/10
#alias xsel='xsel --logfile $XDG_CACHE_HOME/xsel/xsel.log'

# Color ls.
alias ls='ls --color=auto -ah --quoting-style=escape'

# Timer.
alias timer="echo 'Timer started. Stop with Ctrl-D.' && date && time cat && date"

# What's my IP address.
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

# Enhanced WHOIS lookups.
alias whois='whois -h whois.internic.net'

# Currency conversions.
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

# upgrade currently selected kernel
alias kernelup='sudo genkernel --cachedir=/var/tmp/portage --tempdir=/var/tmp/portage --install --udev --postclear --no-save-config --clean --no-lvm --no-mdadm --no-dmraid --zfs --no-btrfs --no-iscsi --no-luks --no-netboot --mountboot --makeopts=-j$(nproc) --ramdisk-modules --kernel-config=$HOME/git/dotfiles_home/kernel/.config all'

# similar to ubuntu's update-grub
alias update-grub='test ! -d /boot/grub && sudo mount /boot; sudo grub-mkconfig -o /boot/grub/grub.cfg && sudo umount /boot'

# clean old kernels
alias clean-kernels='test ! -d /boot/grub && sudo mount /boot; sudo eclean-kernel -n 1 && sudo umount /boot'

# docker-gc with options
alias docker-gc='PID_DIR="$XDG_RUNTIME_DIR" STATE_DIR="$XDG_CACHE_HOME/docker-gc" FORCE_IMAGE_REMOVAL=1 FORCE_CONTAINER_REMOVAL=1 EXCLUDE_FROM_GC="" EXCLUDE_CONTAINERS_FROM_GC="" GRACE_PERIOD_SECONDS=300 docker-gc'

# perms quick-fix
alias dir755='find . -type d -exec chmod 755 {} +'
alias dir700='find . -type d -exec chmod 700 {} +'
alias files644='find . -type f -exec chmod 644 {} +'
alias files600='find . -type f -exec chmod 600 {} +'

# owner quick-fix
alias owneruser='chown -R $(id -u):$(id -g) .'

# git aliases
# https://github.com/robbyrussell/oh-my-zsh/pull/5026
alias gsmc='git diff --name-only --diff-filter=U'
# {push,pull} all repositories in current dir
# https://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories
alias gitpushall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} coms \;'
alias gitpullall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull \;'

# Mpv aliases, mpv as image viewer, simple and quiet mpv.
alias mvi='mpv --profile image'
alias mpvs='mpv --vo=opengl'
alias mpvqs='mpvq --vo=opengl'

# things...
alias internal-ip='ip addr show enp4s0 | grep "inet\b" | awk "{print $2}" | cut -d/ -f1 | sed "s/    inet //g"'

# Shorter
alias rt='tmux -L rt attach -t rt'
alias e='nvim'
alias egrep='grep -E --color'
alias g='git'
alias goodnight='veracrypt -t -d && "$HOME/sync/system-data/backup.sh" -f && sc poweroff -i'
alias grep='grep --color'
alias mus='mpv --profile=novid'
alias mutt='proxychains -q mutt -F ~/.config/mutt/config'
alias o='open'
alias ob='bkg xdg-open'
alias open='xdg-open'
alias sl='streamlink'
alias vim='nvim'

# stuff
alias jc='journalctl'
alias sc='systemctl'
alias scu='sc --user'
alias jcu='jc --user'

alias clearterm='printf "\033c"'
alias back='cd $OLDPWD'
alias flush_caches='sync && sudo sync && sudo sysctl -qw vm.drop_caches=3'
alias reswap='sudo swapoff -a && sudo swapon -a'
alias linuxsteamgames='curl --silent "http://store.steampowered.com/search/?category1=998&os=linux" | grep -o "showing 1 - 25 of [0-9]*" | sed "s/showing 1 - 25 of //"'
alias gogdownload='lgogdownloader --exclude e,c --platform lin,win --use-cache --language ru,en --download --game'
