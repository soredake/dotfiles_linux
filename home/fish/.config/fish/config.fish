# https://github.com/fish-shell/fish-shell/issues/5117
if status --is-login
  if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $__fish_config_dir/functions/fisher.fish
    fish -c fisher
  end
  for sh in /etc/profile.d/*.sh; test -r $sh && bass source $sh; end
  set -gx PATH $PATH $HOME/.local/bin
  echo Hi sempai~
end
set -gx EDITOR "code -w"

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
# Shorter
alias cps 'rsync --archive --compress --progress --verbose --executability -h --update --delete'
alias fd 'fdfind'
alias g 'git'
alias e 'code'
alias exip 'curl -s https://ipecho.net/plain'
#alias finddupes 'jdupes -R -Nd1Ap'
alias jc 'journalctl'
alias jcu 'journalctl --user'
alias nvmestats 'sudo smartctl -A /dev/nvme0'
alias sc 'systemctl'
alias scu 'systemctl --user'
alias t_danet2 'telegram-desktop -many -workdir $HOME/.local/share/TelegramDesktop_danet2'
alias t_danet3 'telegram-desktop -many -workdir $HOME/.local/share/TelegramDesktop_danet3'
alias vts 'echo vitetris --connect (exip):27015 && vitetris -listen 27015'
alias iaupload 'ia upload --no-derive --checksum --verify --retries 10 -H x-archive-keep-old-version:0'

# backup
function backup
  echo "===Local backup==="
  parallel cps $HOME/main ::: /media/danet/{Data,Bigdisk}
  # TODO: https://github.com/rclone/rclone/issues/3683
  parallel rclone dedupe --dedupe-mode newest ::: 50gbmega:/main
  # upload
  echo "===Cloud backup==="
  rclone cleanup gdrive:/
  rclone -P --fast-list move gdrive:/phone-stuff/ $HOME/main/unsorted
  parallel uploadd gphoto:/media/all ::: dropbox:/gphotos_backup
  parallel -j 2 uploadd $HOME/.local/share/data/qBittorrent/BT_backup ::: {dropbox,gdrive,50gbmega}:/qbittorrent
  parallel -j 2 uploadd $HOME/main ::: {gdrive,50gbmega}:/main
  parallel uploadd $HOME/.config/rclone/rclone.conf ::: {dropbox,gdrive,50gbmega}:/
  parallel uploadd $HOME/.ssh ::: {dropbox,gdrive,50gbmega}:/ssh
end

function updatecleanup
  flatpak uninstall --unused # https://github.com/flatpak/flatpak/issues/2639
end

function speak
  trans -speak -s ru $argv -download-audio-as $XDG_RUNTIME_DIR/trans-speak.ts
  ffmpeg -y -i $XDG_RUNTIME_DIR/trans-speak.ts $XDG_RUNTIME_DIR/trans-speak.ogg
  echo $XDG_RUNTIME_DIR/trans-speak.ogg | xclip -i -selection clipboard
end