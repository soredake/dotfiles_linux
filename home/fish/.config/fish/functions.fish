function mkd
  mkdir -p $argv && cd $_ || exit 1;
end

# Convert currencies; cconv {amount} {from} {to}
#cconv() {
  #| grep '&#8372;</strong>'
  #result="$(curl -s "https://exchangerate.guru/$2/$3/$1/" | grep --color=never -o -P '(?<=<input data-role="secondary-input" type="text" class="form-control" value=").*(?=" required>)')"
  #echo "$1 $2 = $result $3"
#}

# 5gb max, stores for 24 hours
function cockfile
  curl --progress-bar -F file=@"$1" https://cockfile.com/api.php?d=upload-tool
end

#j() {
#case "$1" in
#  d) cd "$HOME/main/Documents" ;;
#  g) cd "$HOME/git" ;;
#  m) cd "/media" ;;
#  s) cd "$HOME/main" ;;
#  t) cd /media/disk0/torrents ;;
#  *) echo "No folder defined for this alias." ;;
#esac
#}

# 512mb max, stores for 30+ days
function 0x0
  #if [[ "$1" =~ ^http?[s]://.*$ ]]; then local prefix="url="; else local prefix="file=@"; fi
  curl -F"$prefix$1" https://0x0.st
end

# backup
function backup
  # local
  cps "$HOME/main" /media/disk0/backup
  cps -L "$HOME/share" /media/disk0/backup
  cps "$HOME/main/Documents/NewDatabase.kdbx" "/media/disk2/Users/User/Desktop"
  cps "$HOME/main/Documents/NewDatabase.kdbx" "$HOME/share"
  # fix errors like `some-file.jpg: Duplicate object found in destination - ignoring` https://github.com/rclone/rclone/issues/2131#issuecomment-372459713
  rclone dedupe --dedupe-mode newest 50gbmega:/
  rclone dedupe --dedupe-mode newest 15gbmega:/
  # dropbox 2gb
  # TODO: https://plati.ru/search/DROPBOX
  echo "Uploading to Dropbox"
  uploadd "$HOME/main/Documents" dropbox:/Documents
  # google drive 15gb
  echo "Google Drive"
  uploadd "$HOME/main" gdrive:/
  # mega.nz 50gb
  echo "Uploading to MEGA 50gb"
  uploadd "$HOME/main" 50gbmega:/
  # mega.nz 15gb
  echo "Uploading to MEGA 15gb"
  uploadd "$HOME/main" 15gbmega:/
  # yandex.disk 10gb
  echo "Uploading to Yandex.Disk"
  uploadd "$HOME/main" yandex:/
end

# ukr nalogi
# https://duckduckgo.com/?q=(400+-+165)+*+35%25&ia=calculator
# https://rozetka.com.ua/news-articles-promotions/promotions/261738.html
#function ukr-nalogi
#  if [[ "$1" -ge "151" ]]; then
    #poshlina=$(bc -l <<< "($1 - 150) * 0.10")
#    echo Tax is: $(bc -l <<< "($1 - 100 + $poshlina) * 0.20 + $poshlina") EUR
 # else
#    echo Tax is: $(bc -l <<< "($1 - 100) * 0.20") EUR
#  end
#end

# https://www.checkyourmath.com/convert/length/inches_cm.php
function cmtoinch
#  echo $(bc -l <<< "$1 / 2.54")
end
function inchtocm
 # echo $(bc -l <<< "$1 * 2.54")
end

# update everything
function update
  yay -Syuu --combinedupgrade --answerclean n --answerdiff n --answerupgrade y --noconfirm
  sudo etc-update
  flatpak --user update --noninteractive
  snap refresh
  fwupdmgr refresh
  fwupdmgr update
  zinit self-update
  zinit update
  tldr --update
end

function speak
  trans -speak -s ru "$1" -download-audio-as "$XDG_RUNTIME_DIR/trans-speak.ts"
  ffmpeg -y -i "$XDG_RUNTIME_DIR/trans-speak.ts" "$XDG_RUNTIME_DIR/trans-speak.ogg"
  echo "$XDG_RUNTIME_DIR/trans-speak.ogg" | clipcopy
end