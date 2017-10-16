# shellcheck disable=2034,2148

# play all in mpv
mpa() { if [[ -d "${PWD}/VIDEO_TS" ]] || [[ -d "${PWD}/BDMV" ]]; then
    mpv "${PWD}"
  else
    files=( $(ls -b ${PWD}/*.{mp4,mkv,webm,avi,wmv} 2>/dev/null) )
    mpv "${PWD}"/"${1:-${files[@]}}" "$2"
  fi
}

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
cconv() {
  curl --socks5-hostname 127.0.0.1:9250 -s "https://www.google.com/finance/converter?a=$1&from=$2&to=$3&hl=es" | sed '/res/!d;s/<[^>]*>//g';
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
  curl -A curl -k https://wttr.in/"${1:-moon}"?lang=ru
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
  echo 'PPI is:' "$(bc <<< "sqrt($1^2+$2^2)/$3")"
}

# 5gb max
# stores for 90 days
#lewdse() {
#   if [[ "$1" =~ ^https?://.*$ ]]; then local prefix="curl --fail -L --progress-bar --socks5-hostname 127.0.0.1:9250 ${1} || exit 1"; else local suffix="${1}"; fi
   # eval or sh -c
#   eval "${prefix:-true}" | curl --fail -L --progress-bar --socks5-hostname 127.0.0.1:9250 -F name="${2:-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1 | grep -i '[a-zA-Z0-9]').${1##*.}}" -F file=@"${suffix:--}" https://lewd.se/api.php?d=upload-tool
#}

# Validate tar archives
tarval() {
  tar -tJf "$@" >/dev/null
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

# Algorithm borrowed from http://wiki.rtorrent.org/MagnetUri and adapted to work with zsh.
# Copied from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/torrent/torrent.plugin.zsh
magnet_to_torrent() {
  [[ "$1" =~ xt=urn:btih:([^\&/]+) ]] || return 1
  hashh=${match[1]}
  if [[ "$1" =~ dn=([^\&/]+) ]]; then
    filename=${match[1]}
  else
    filename=$hashh
  fi
  echo "d10:magnet-uri${#1}:${1}e" > "$filename.torrent"
}


px() {
  # https://stackoverflow.com/questions/23258413/expand-aliases-in-non-interactive-shells/23259088#23259088
  setopt aliases
  _command="$(which "$1" | sed 's/.*: aliased to //g' )"
  eval proxychains -q "$_command" $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16 $17 $18 $19 $20 $21 $22 $23 $24 $25 $26 $27 $28 $29 $30 $31 $32 $33 $34 $35 $36 $37 $38 $39 $40 $41 $42 $43 $44 $45 $46 $47 $48 $49 $50
}

j() {
case "$1" in
  g) cd "$HOME/git" ;;
  s) cd "$HOME/sync" ;;
  t) cd /media/disk0/torrents ;;
  gd) cd "$HOME/sync/main/Documents/googledocs" ;;
  dch) cd "$HOME/sync/main/Documents/dollchan" ;;
  b) cd "$HOME/sync/main/Documents/bookmarks" ;;
  bak) cd "$HOME/sync/system-data" ;;
  m) cd "$HOME/media" ;;
  *) echo "No folder defined for this alias." ;;
esac
}

#wp() {
#  if [[ ! -z "$3"]]; then desktop="explorer /desktop=$(basename $1),$3"; fi
#  WINEPREFIX="$XDG_DATA_HOME/wineprefix/${2:-steam}" wine "$1" "$2" ${desktop}
#}

wtp() {
  winetricks prefix="$XDG_DATA_HOME/wineprefix/$@"
}

# upgrade currently selected kernel
kernelup() { 
  sudo genkernel --cachedir=/var/tmp/portage --tempdir=/var/tmp/portage --install --udev --virtio --postclear --no-save-config --clean --no-lvm --no-mdadm --no-dmraid --zfs --no-btrfs --no-iscsi --no-luks --no-netboot --mountboot --makeopts=-j$(nproc) --ramdisk-modules --kernel-config="$HOME/git/dotfiles_home/kernel/.config" "${@:-all}" 
}

# kernel update
kupdate() {
	local cur_v="$(eselect kernel show | grep -o [0-9]\.[0-9][0-9]?\.[0-9][0-9]? | sed 's/\./_/g')"
	sudo cp "$HOME/git/dotfiles_home/kernel/.config" /usr/src/linux
	pushd /usr/src/linux
	sudo make olddefconfig
	popd
	cp /usr/src/linux/.config "$HOME/git/dotfiles_home/kernel/.config"
	cp /usr/src/linux/.config "$HOME/git/dotfiles_home/kernel/.config_${cur_v}"
	kernelup
	sudo emerge @module-rebuild --usepkg=n
	kernelup initramfs
	update-grub
}

random() {
  shuf -i "${1}-${2}" -n "${3:-1}"
}
