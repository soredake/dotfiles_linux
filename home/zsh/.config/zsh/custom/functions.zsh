# shellcheck disable=2034,2148

# Create a new directory and enter it.
# In oh-my-zsh take function is identical to this
mkd() {
  mkdir -p "$@" && cd "$_" || exit 1;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Convert currencies; cconv {amount} {from} {to}
# https://stackoverflow.com/questions/13242469/how-to-use-sed-grep-to-extract-text-between-two-words
cconv() {
  #| grep '&#8372;</strong>'
  result="$(curl -s "https://exchangerate.guru/$2/$3/$1/" | grep --color=never -o -P '(?<=<input data-role="secondary-input" type="text" class="form-control" value=").*(?=" required>)')"
  echo "$1 $2 = $result $3"
}

# Upload to transfer.sh
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
             tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> "$tmpfile"; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> "$tmpfile" ; fi; cat "$tmpfile"; rm -f "$tmpfile"; }

# Background with log
# https://github.com/mpv-player/mpv/issues/1377#issuecomment-90370504
bkg() {
  logfile=$(mktemp -t "$(basename $1)"-"$(date +%d.%m.%G-%T)"-XXX.log)
  nohup "$@" &>"$logfile" &
}

wttr() {
  # moon or city name
  curl -A curl -k https://wttr.in/"${1}"?lang=ru
}

# Calculate actual size of {HD,SS}D; actualsize {size} {gb}[optional, use gigabytes instead of terabytes]
# http://www.sevenforums.com/hardware-devices/23890-hdds-advertized-size-vs-actual-size.html
actualsize() {
  if [[ "$2" == gb ]]; then a="0.9313226"; else a="0.9094947"; fi
  echo 'Actual size is:' "$(bc -l <<< "$1 * $a")"
}

# Calculate ppi; ppicalc {widght} {height} {display size[eg 27]}
# http://isthisretina.com/
# https://en.wikipedia.org/wiki/Pixel_density#Calculation_of_monitor_PPI
ppicalc() {
  echo 'DPI/PPI is:' "$(bc <<< "sqrt($1^2+$2^2)/$3")"
}

# 5gb max
# stores for 24 hours
cockfile() {
   if [[ "$1" =~ ^https?://.*$ ]]; then local prefix="curl --fail -L --progress-bar ${1} || exit 1"; else local suffix="${1}"; fi
   # eval or sh -c
   eval "${prefix:-true}" | curl --fail -L --progress-bar -F name="${2:-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1 | grep -i '[a-zA-Z0-9]').${1##*.}}" -F file=@"${suffix:--}" https://cockfile.com/api.php?d=upload-tool
}

# Automatically cd to the directory you were in when quitting ranger if you haven't already:
ranger() {
    tempfile="$(mktemp -t ranger-tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n "$(pwd)")" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

# https://www.pixelstech.net/article/1352825068-Use-rsync-to-delete-mass-files-quickly-in-Linux
# https://unix.stackexchange.com/a/277205
# https://www.slashroot.in/which-is-the-fastest-method-to-delete-files-in-linux
# https://serverfault.com/questions/183821/rm-on-a-directory-with-millions-of-files/328305#328305
# https://github.com/edannenberg/kubler/blob/master/engine/docker/bob-core/portage-git-sync.sh#L12
fastdelete() {
  _tmp=$(mktemp -d /tmp/XXX)
  [[ "$2" = "s" ]] && s=sudo
  eval "${s}" rsync -a --delete "$_tmp"/ "$1" || exit 1
  eval "${s}" rmdir "$1" "$_tmp"
}

px() {
  # https://stackoverflow.com/questions/23258413/expand-aliases-in-non-interactive-shells/23259088#23259088
  setopt aliases
  _command="$(which "$1" | sed 's/.*: aliased to //g' )"
  # http://wiki.bash-hackers.org/syntax/pe#substring_expansion
  eval proxychains -q "$_command" ${@:2}
}

j() {
case "$1" in
  b) cd "$HOME/sync/main/Documents/system-data" ;;
  d) cd "$HOME/sync/main/Documents" ;;
  g) cd "$HOME/git" ;;
  m) cd "/media" ;;
  s) cd "$HOME/sync/main" ;;
  t) cd /media/disk0/torrents ;;
  *) echo "No folder defined for this alias." ;;
esac
}

linuxsteamgames() {
  _url="https://store.steampowered.com/search/?category1=998&os="
  for os in win linux mac; do
    local ${os}games="$(curl --http2 -s "${_url}${os}" | grep -o "showing 1 - 25 of [0-9]*" | sed "s/showing 1 - 25 of //")"
  done
  echo "Windows steam games: ${wingames}"
  echo "Mac steam games: ${macgames}"
  echo "Linux steam games: ${linuxgames}"
  # https://stackoverflow.com/a/41265735
  echo "Percentage of linux games compared to windows:" $(echo "scale = 2; ($linuxgames / $wingames)" | bc -l | awk -F '.' '{print $2}')%
  echo "Percentage of linux games compared to macOS:" $(echo "scale = 2; ($linuxgames / $macgames)" | bc -l | awk -F '.' '{print $2}')%
}

# https://stackoverflow.com/a/10060342
# https://stackoverflow.com/a/10060342
# 512mb max
# stores for 30+ days
0x0() {
  if [[ "$1" =~ ^http?[s]://.*$ ]]; then local prefix="url="; else local prefix="file=@"; fi
  curl -F"${prefix}${1}" https://0x0.st
}

# rclone alias
# https://stackoverflow.com/questions/45601589/zsh-not-recognizing-alias-from-within-function
# https://stackoverflow.com/questions/25532050/newly-defined-alias-not-working-inside-a-function-zsh
# TODO remove when https://github.com/rclone/rclone/issues/2697 is done
alias -g upload="rclone sync --transfers 8 --delete-excluded --fast-list -P --delete-before"

# backup
backup() {
  # local
  cps -L "$HOME/sync" /media/disk0/backup
  cps "$HOME/sync/main/Documents/NewDatabase.kdbx" "/media/disk2/Users/User/Desktop/"
  cps "$HOME/sync/main/Documents/NewDatabase.kdbx" "$HOME/sync/share/"
  # fix errors like `some-file.jpg: Duplicate object found in destination - ignoring` https://github.com/rclone/rclone/issues/2131#issuecomment-372459713
  rclone dedupe --dedupe-mode newest 50gbmega:/
  rclone dedupe --dedupe-mode newest mega_nz:/
  # dropbox
  # 2gb
  # TODO: https://plati.ru/search/DROPBOX
  echo -e "\e[1;31m Uploading to Dropbox \033[0m"
  upload "$HOME/sync/main/Documents" dropbox:/Documents
  # opendrive
  # 5gb
  echo -e "\e[1;31m Uploading to OpenDrive \033[0m"
  upload "$HOME/sync/main/Documents" opendrive:/Documents
  upload "$HOME/sync/main/Media" opendrive:/Media
  # google drive
  # 15gb
  echo -e "\e[1;31m Google Drive \033[0m"
  upload "$HOME/sync/main/Documents" google_drive:/Documents
  upload "$HOME/sync/main/Media" google_drive:/Media
  upload "$HOME/sync/main/me" google_drive:/me
  # mega.nz
  # 50gb
  echo -e "\e[1;31m Uploading to MEGA 50gb \033[0m"
  upload "$HOME/sync/main/Documents" 50gbmega:/Documents
  upload "$HOME/sync/main/Media" 50gbmega:/Media
  upload "$HOME/sync/main/me" 50gbmega:/me
  # mega.nz
  # 15gb
  echo -e "\e[1;31m Uploading to MEGA 15gb \033[0m"
  upload "$HOME/sync/main/Documents" mega_nz:/Documents
  upload "$HOME/sync/main/Media" mega_nz:/Media
  upload "$HOME/sync/main/me" mega_nz:/me
  # yandex.disk
  # 10gb
  echo -e "\e[1;31m Uploading to Yandex.Disk \033[0m"
  upload "$HOME/sync/main/Documents" yandex:/Documents
  upload "$HOME/sync/main/Media" yandex:/Media
  upload "$HOME/sync/main/me" yandex:/me
}

# workaround for https://github.com/citra-emu/citra/issues/3862
yuzu-binary() {
  [[ ! -f "libsndio.so.6.1" ]] && ln -sfv /usr/lib/libsndio.so.7.0 libsndio.so.6.1
  LD_LIBRARY_PATH=$PWD strangle 60 gamemoderun ./yuzu
}

# https://shapeshed.com/zsh-corrupt-history-file/
# https://dev.to/rishibaldawa/fixing-corrupt-zsh-history-4nf4
fix_zsh_history() {
  cd "$XDG_DATA_HOME/zsh"
  mv history history_bad
  strings history_bad > history
  fc -R history
  rm -f history_bad
}

# https://wiki.archlinux.org/index.php/Color_output_in_console#Using_less
man() {
   LESS_TERMCAP_md=$'\e[01;31m' \
   LESS_TERMCAP_me=$'\e[0m' \
   LESS_TERMCAP_se=$'\e[0m' \
   LESS_TERMCAP_so=$'\e[01;44;33m' \
   LESS_TERMCAP_ue=$'\e[0m' \
   LESS_TERMCAP_us=$'\e[01;32m' \
   command man "$@"
}

# ukr nalogi
# https://duckduckgo.com/?q=(400+-+165)+*+35%25&ia=calculator
# https://rozetka.com.ua/news-articles-promotions/promotions/261738.html
ukr_nalogi() {
  if [[ "$1" -ge "151" ]]; then
    poshlina=$(bc -l <<< "($1 - 150) * 0.10")
    echo Tax is: $(bc -l <<< "($1 - 100 + $poshlina) * 0.20 + $poshlina") EUR
  else
    echo Tax is: $(bc -l <<< "($1 - 100) * 0.20") EUR
  fi
}

speedfox() {
  array=( $(pgrep -f plugin-container) )
  array+=( $(pgrep -f ^firefox) )
  for pid in "${array[@]}"; do
    sudo renice -n -20 -p "$pid"
    sudo ionice -c realtime -p "$pid" && echo "Changed io priority to realtime for pid $pid"
  done
}

# https://www.checkyourmath.com/convert/length/inches_cm.php
cmtoinch() { echo $(bc -l <<< "$1 / 2.54"); }
inchtocm() { echo $(bc -l <<< "$1 * 2.54"); }

# update everything
update() {
  yay -Syuu --combinedupgrade --answerclean n --answerdiff n --answerupgrade y --noconfirm
  sudo etc-update
  #apm update --confirm false
  flatpak --user update --noninteractive
  #yarn global upgrade
  #fwupdmgr refresh
  #fwupdmgr update
  zplugin self-update
  zplugin update
  tldr --update
}