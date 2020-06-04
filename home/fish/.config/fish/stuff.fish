# Confirm before overwriting
# I know it is bad practice to override the default commands, but this is for
# my own safety. If you really want the original "instakill" versions, you can
# use "command rm", "\rm", or "/bin/rm" inside your own commands, aliases, or
# shell functions. Note that separate scripts are not affected by the aliases
# defined here.
alias mv='/bin/mv -i'
alias rm='/bin/rm -i'
alias cp='/bin/cp -i'
# rclone alias
# TODO: remove when https://github.com/rclone/rclone/issues/2697 is done
alias uploadd 'rclone sync (status is-interactive && echo -P) --transfers 6 --fast-list --delete-before'
# Better copy, move, copy with update and synchronize folder aliases
alias mrsync 'rsync --archive --compress --progress --verbose --executability -h'
alias bcp 'mrsync'
alias bmv 'mrsync --remove-source-files'
alias cpu 'mrsync --update'
alias cps 'mrsync --update --delete'
# Shorter
alias fd 'fdfind'
alias g 'git'
alias e 'code'
alias vm 'gamemoderun vmplayer'
alias exip 'curl -s https://ipecho.net/plain'
alias finddupes 'jdupes -R -Nd1Ap'
alias jc 'journalctl'
alias jcu 'journalctl --user'
alias nvmestats 'sudo smartctl -A /dev/nvme0'
alias sc 'systemctl'
alias scu 'systemctl --user'
alias t_danet2 'telegram-desktop -many -workdir $HOME/.local/share/TelegramDesktop_danet2'
alias t_danet3 'telegram-desktop -many -workdir $HOME/.local/share/TelegramDesktop_danet3'
alias vts 'echo vitetris --connect (exip):27015 && vitetris -listen 27015'
alias iaupload 'ia upload --checksum --verify --retries 10 -H x-archive-keep-old-version:0'

# backup
function backup
  echo "===Local backup==="
  parallel cps $HOME/main ::: /media/danet/{Data,Bigdisk}
  # TODO: https://github.com/rclone/rclone/issues/3683
  parallel rclone dedupe --dedupe-mode newest ::: {15,50}gbmega:/main
  # upload
  echo "===Cloud backup==="
  rclone cleanup gdrive:/
  rclone -P --fast-list move gdrive:/phone-stuff/ $HOME/main/unsorted
  parallel uploadd gphoto:/media/all ::: dropbox:/gphotos_backup
  parallel -j 2 uploadd $HOME/.local/share/data/qBittorrent/BT_backup ::: {dropbox,gdrive,{15,50}gbmega}:/qbittorrent
  parallel -j 2 uploadd $HOME/main ::: {gdrive,{15,50}gbmega}:/main
  parallel uploadd $HOME/.config/rclone/rclone.conf ::: {dropbox,gdrive,{15,50}gbmega}:/
  parallel uploadd $HOME/.ssh ::: {dropbox,gdrive,{15,50}gbmega}:/ssh
end

# update everything
function update
  fisher self-update
  fisher
end

function cleanup
  flatpak --user uninstall --unused # https://github.com/flatpak/flatpak/issues/2639
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