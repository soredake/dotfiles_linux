# Shorter
# https://wiki.archlinux.org/index.php/Kexec
alias kernelup "sudo kexec -l /boot/vmlinuz-linux-tkg-bmq-zen --initrd=/boot/initramfs-linux-tkg-bmq-zen.img --reuse-cmdline && systemctl kexec"
# find broken symlinks
alias badlinks 'find . -type l -exec test ! -e {} \; -print'
# https://wiki.archlinux.org/index.php/.SRCINFO https://wiki.archlinux.org/index.php/Arch_package_guidelines
alias aurup 'makepkg --printsrcinfo > .SRCINFO; updpkgsums'
alias back 'cd $OLDPWD'
alias build_all 'build_faudio && build_wine && build_proton'
alias build_faudio 'tkgup; cd faudio-git && makepkg -si' # https://github.com/Tk-Glitch/PKGBUILDS/issues/458#issuecomment-575811620 and https://git.archlinux.org/svntogit/community.git/tree/trunk/PKGBUILD?h=packages/lib32-faudio#n30 # TODO: https://github.com/FNA-XNA/FAudio/pull/161
alias build_proton 'tkgup; cd proton-tkg && ./proton-tkg.sh' # TODO: https://github.com/FNA-XNA/FAudio/pull/161
alias build_wine 'tkgup; cd wine-tkg-git && makepkg -si' # TODO: back to staging when mingw, fsync and fs{hack,bypass} is merged
#alias build_staging 'tkgup; cd wine-tkg-git && _EXT_CONFIG_PATH=$HOME/git/PKGBUILDS/wine-tkg-git/wine-tkg-profiles/wine-tkg-staging.cfg makepkg -si'
alias e 'code'
alias exip 'curl -s https://ipecho.net/plain'
alias g 'git'
alias jc 'journalctl'
alias jcu 'journalctl --user'
alias linkmusic 'ln -sfv /media/disk0/torrents/Music/* "$HOME/Music"'
alias ls 'ls --color=auto -ah --quoting-style=escape --group-directories-first'
alias mountandroidfs 'sshfs -o kernel_cache android:/ /media/android'
alias sc 'systemctl'
alias scu 'systemctl --user'
alias tkgup 'cd $HOME/git/PKGBUILDS; git reset --hard origin/master; git pull'
alias vts 'echo vitetris --connect (exip):27015 && vitetris -listen 27015'