#!/bin/bash
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# https://github.com/TingPing/flatpak-packages/issues/11
flatpak --user remote-add tingping https://dl.tingping.se/flatpak/tingping.flatpakrepo
flatpak --user install tingping net.lutris.Lutris