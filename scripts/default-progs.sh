#!/bin/bash
# find mimetype by command: mimetype (dev-perl/File-MimeInfo) img.webm
# or file --mime-type -b img.webm

sudo rm -rf "$XDG_CONFIG_HOME/mimeapps.list" "$XDG_DATA_HOME/"{mimeapps.list,mimeinfo.cache} /usr/share/applications/mimeinfo.cache
# https://wiki.archlinux.org/index.php/default_applications#Default_mimeapps.list_files
rm "$XDG_DATA_HOME/applications/"{mimeapps.list,mimeinfo.cache}

rm -r "$XDG_DATA_HOME/mime"

# audio and video player
xdg-mime default mpv.desktop application/ogg application/x-ogg application/sdp application/smil application/x-smil application/streamingmedia application/x-streamingmedia application/vnd.rn-realmedia application/vnd.rn-realmedia-vbr audio/aac audio/x-aac audio/m4a audio/x-m4a audio/mp1 audio/x-mp1 audio/mp2 audio/x-mp2 audio/mp3 audio/x-mp3 audio/mpeg audio/x-mpeg audio/mpegurl audio/x-mpegurl audio/mpg audio/x-mpg audio/rn-mpeg audio/ogg audio/scpls audio/x-scpls audio/vnd.rn-realaudio audio/wav audio/x-pn-windows-pcm audio/x-realaudio audio/x-pn-realaudio audio/x-ms-wma audio/x-pls audio/x-wav video/mpeg video/x-mpeg video/x-mpeg2 video/mp4 video/msvideo video/x-msvideo video/ogg video/quicktime video/vnd.rn-realvideo video/x-ms-afs video/x-ms-asf video/x-ms-wmv video/x-ms-wmx video/x-ms-wvxvideo video/x-avi video/x-fli video/x-flv video/x-theora video/x-matroska video/webm audio/x-flac audio/x-vorbis+ogg video/x-ogm+ogg audio/x-shorten audio/x-ape audio/x-wavpack audio/x-tta audio/AMR audio/ac3 video/mp2t audio/flac audio/mp4

# Image viewer
xdg-mime default mvi.desktop image/gif image/jpeg image/png image/bmp image/x-eps image/x-ico image/x-portable-bitmap image/x-portable-graymap image/x-portable-pixmap image/x-xbitmap image/x-xpixmap

# Browser
xdg-mime default firefox.desktop text/html text/xml application/xhtml+xml application/vnd.mozilla.xul+xml text/mml x-scheme-handler/http x-scheme-handler/https

# Folder opening
xdg-mime default ranger.desktop inode/directory

# Documents
xdg-mime default libreoffice-writer.desktop application/vnd.oasis.opendocument.text

# Spreadsheets
xdg-mime default libreoffice-calc.desktop application/vnd.oasis.opendocument.spreadsheet

# Steam
xdg-mime default steam-fixed.desktop x-scheme-handler/steam

# update mime db
sudo update-desktop-database -v "$XDG_DATA_HOME/applications" /usr/share/applications
