function mkd
  mkdir -p $argv && cd $argv || exit 1;
end

# Convert currencies; cconv {amount} {from} {to}
function cconv
  #| grep '&#8372;</strong>'
  set result (curl -s "https://exchangerate.guru/$argv[2]/$argv[3]/$argv[1]/" | grep --color=never -o -P '(?<=<input data-role="secondary-input" type="text" class="form-control" value=").*(?=" required>)')
  echo "$argv[1] $argv[2] = $result $argv[3]"
end

# 5gb max, stores for 24 hours
function cockfile
  curl --progress-bar -F file=@$argv https://cockfile.com/api.php?d=upload-tool
end

function j
switch $argv
  case d
    cd $HOME/main/Documents
  case g 
    cd $HOME/git
  case m
    cd /media
  case s
    cd $HOME/main
  case t
    cd /media/disk0/torrents
  case '*'
    echo "No folder defined for this alias."
end
end

# 512mb max, stores for 30+ days
function 0x0
  if string match --regex "http?[s]://.*" $argv[1]
    set prefix "url="
  else
    set prefix "file=@"
  end
  curl -F$prefix$argv https://0x0.st
end

# backup
function backup
  # local
  cps $HOME/main /media/disk1/share /media/disk0
  parallel cps $HOME/main/Documents/NewDatabase.kdbx ::: /media/disk2/Users/User/Desktop /media/disk1/share
  # fix errors like `some-file.jpg: Duplicate object found in destination - ignoring` https://github.com/rclone/rclone/issues/2131#issuecomment-372459713
  rclone dedupe --dedupe-mode newest 50gbmega:/
  rclone dedupe --dedupe-mode newest 15gbmega:/
  # dropbox 2gb
  # TODO: https://plati.ru/search/DROPBOX
  echo "Uploading to Dropbox"
  uploadd $HOME/main/Documents dropbox:/Documents
  # google drive 15gb
  echo "Uploading to Google Drive"
  uploadd $HOME/main gdrive:/
  # mega.nz 50gb
  echo "Uploading to MEGA 50gb"
  uploadd $HOME/main 50gbmega:/
  # mega.nz 15gb
  echo "Uploading to MEGA 15gb"
  uploadd $HOME/main 15gbmega:/
end

# update everything
function update
  yay -Syuu --combinedupgrade --answerclean n --answerdiff n --answerupgrade y --noconfirm
  sudo etc-update
  flatpak --user update --noninteractive
  snap refresh
  fwupdmgr refresh
  fwupdmgr update
  fisher
  fisher self-update
  tldr --update
end

function cleanup
  if string match -q m $argv
    ancient-packages -q
    #fd -t d -H ".unwanted" /media/disk0/torrents -x rm -r {}
    return
  end
  #fd -t f -H -I -e .tar.zst --search-path $HOME/git/PKGBUILDS -x "rm" {}
  flatpak --user uninstall --unused # https://github.com/flatpak/flatpak/issues/2639
  yay -Sc --noconfirm
  # TODO: https://github.com/Jguer/yay/issues/1112
  #yay -c --noconfirm
end

function speak
  trans -speak -s ru $argv -download-audio-as $XDG_RUNTIME_DIR/trans-speak.ts
  ffmpeg -y -i $XDG_RUNTIME_DIR/trans-speak.ts $XDG_RUNTIME_DIR/trans-speak.ogg
  echo $XDG_RUNTIME_DIR/trans-speak.ogg | xclip -i -selection clipboard
end