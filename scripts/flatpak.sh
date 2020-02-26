#!/bin/bash
# https://wiki.archlinux.org/index.php/Flatpak#Add_a_repository
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# jdownloader2
flatpak --user install flathub org.jdownloader.JDownloader

sudo snap install copay