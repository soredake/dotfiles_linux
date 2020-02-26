# shellcheck disable=2034,2148
# Enable simple aliases to be sudo'ed. ("sudone"?)
# https://www.gnu.org/software/bash/manual/bashref.html#Aliases says: "If the
# last character of the alias value is a space or tab character, then the next
# command word following the alias is also checked for alias expansion."
alias s='sudo '
alias px='proxychains '

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
alias mrsync='rsync --archive --hard-links --acls --xattrs -zz --progress --verbose --executability -h'
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

# color
alias egrep='grep -E --color'
alias diff='diff --color'
alias grep='grep --color'

# git aliases
# {push,pull} all repositories in current dir
# https://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories
alias gitpushall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} coms \;'
alias gitpullall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull \;'

# Shorter
# find broken symlinks
alias badlinks='find . -type l -exec test ! -e {} \; -print'
# Currency conversions
alias usd='cconv 1 usd uah'
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
alias link_wine_patches='cd $HOME/git/wine-tkg-userpatches; git pull; ln -sfv $PWD/*.mypatch $HOME/git/PKGBUILDS/wine-tkg-git/wine-tkg-userpatches'
alias build_all='goggalaxy && build_faudio && build_wine && build_proton'
alias goggalaxy='cd $HOME/git/PKGBUILDS/wine-tkg-git/wine-tkg-userpatches; wget https://raw.githubusercontent.com/lutris/buildbot/master/runners/wine/build-preparation/patches/GalaxyFix-AddSetEnvironmentStringsW-stub.mypatch'
alias build_faudio='tkgup; cd faudio-git && makepkg -si' # https://github.com/Tk-Glitch/PKGBUILDS/issues/458#issuecomment-575811620 and https://git.archlinux.org/svntogit/community.git/tree/trunk/PKGBUILD?h=packages/lib32-faudio#n30
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
alias tkgup='cd $HOME/git/PKGBUILDS; git reset --hard origin/master; git pull'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias vts='echo vitetris --connect $(exip):27015 && vitetris -listen 27015'
alias yuzu='gamemoderun yuzu'
