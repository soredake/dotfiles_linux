# rclone alias
# TODO: remove when https://github.com/rclone/rclone/issues/2697 is done
alias uploadd 'rclone sync --fast-list --delete-before'
# Better copy, move, copy with update and synchronize folder aliases
# --archive = archive mode; equals -rlptgoD (no -H,-A,-X)
alias mrsync='rsync --archive --hard-links --acls --xattrs --compress --progress --verbose --executability -h'
alias bcp='mrsync'
alias bmv='mrsync --remove-source-files'
alias cpu='mrsync --update'
alias cps='mrsync --update --delete'
# Shorter
#alias build_mainline 'tkgup; cd wine-tkg-git/wine-tkg-git && timeout 2 ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-mainline.cfg; ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-mainline.cfg'
#alias build_staging 'tkgup; cd wine-tkg-git/wine-tkg-git && timeout 2 ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-staging.cfg; ./non-makepkg-build.sh $HOME/.config/frogminer/wine-tkg-staging.cfg'
#alias tkgup 'cd $HOME/git/PKGBUILDS; git reset --hard origin/frogging-family; git submodule foreach --recursive git reset --hard origin; git pull'
alias badlinks 'find . -type l -exec test ! -e {} \; -print'
alias e 'code'
alias exip 'curl -s https://ipecho.net/plain'
alias finddupes 'jdupes -R -Nd1Ap'
alias g 'git'
alias jc 'journalctl'
alias jcu 'journalctl --user'
alias linkmusic 'ln -sfv /media/danet/Bigdisk/torrents/Music/* $HOME/Music'
alias nvmestats 'sudo smartctl -A /dev/nvme0'
alias sc 'systemctl'
alias scu 'systemctl --user'
alias t_danet2 'telegram-desktop -many -workdir $HOME/.local/share/TelegramDesktop_danet2'
alias t_danet3 'telegram-desktop -many -workdir $HOME/.local/share/TelegramDesktop_danet3'
alias vts 'echo vitetris --connect (exip):27015 && vitetris -listen 27015'

function mkd
  mkdir -p $argv && cd $argv || exit 1;
end

# Convert currencies; cconv {amount} {from} {to}
function cconv
  #| grep '&#8372;</strong>'
  set result (curl -s "https://exchangerate.guru/$argv[2]/$argv[3]/$argv[1]/" | grep --color=never -o -P '(?<=<input data-role="secondary-input" type="text" class="form-control" value=").*(?=" required>)')
  echo "$argv[1] $argv[2] = $result $argv[3]"
end

# backup
function backup
  cps $HOME/{main,share} /media/danet/Bigdisk
  cps $HOME/main/NewDatabase.kdbx "/media/danet/Windows 10/Users/User/Desktop"
  # fix errors like `some-file.jpg: Duplicate object found in destination - ignoring` https://github.com/rclone/rclone/issues/2131#issuecomment-372459713
  parallel rclone dedupe --dedupe-mode newest ::: {15,50}gbmega:/
  # upload
  parallel uploadd $HOME/.ssh ::: {dropbox,gdrive,{15,50}gbmega}:/ssh
  parallel uploadd $HOME/.local/share/data/qBittorrent/BT_backup ::: {dropbox,gdrive,{15,50}gbmega}:/qbittorrent
  parallel uploadd $HOME/main ::: {gdrive,{15,50}gbmega}:/
  uploadd $HOME/main/me dropbox:/me
end

# update everything
function update
  #sudo apt update
  #sudo apt full-upgrade
  #sudo etc-update
  #flatpak --user update --noninteractive
  #snap refresh
  #fwupdmgr refresh
  #fwupdmgr update
  fisher
  fisher self-update
end

function cleanup
  flatpak --user uninstall --unused # https://github.com/flatpak/flatpak/issues/2639
  sudo apt-get autoremove
  sudo apt-get autoclean
  sudo apt-get clean
end

function speak
  trans -speak -s ru $argv -download-audio-as $XDG_RUNTIME_DIR/trans-speak.ts
  ffmpeg -y -i $XDG_RUNTIME_DIR/trans-speak.ts $XDG_RUNTIME_DIR/trans-speak.ogg
  echo $XDG_RUNTIME_DIR/trans-speak.ogg | xclip -i -selection clipboard
end

# sync kde5 places to gtk3 bookmarks
# https://askubuntu.com/questions/694283/how-do-i-sync-kde-5-places-folder-bookmarks-to-gtk-3
function syncgtkbmarks
  awk -F\" '/<bookmark href=\"file/ {print $2}' < "$HOME/.local/share/user-places.xbel" > "$HOME/.config/gtk-3.0/bookmarks"
  # replace space with %20 to fix bookmarks
  sed -i "s/ /%20/g" "$HOME/.config/gtk-3.0/bookmarks"
end