#!/bin/bash
# https://github.com/TingPing/flatpak-packages/issues/11
#flatpak --user remote-add tingping https://dl.tingping.se/flatpak/tingping.flatpakrepo
#flatpak --user install tingping net.lutris.Lutris

# https://neverware.zendesk.com/hc/en-us/community/posts/360002990188-Flatpak-doesn-t-work-What-s-wrong
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# https://flatpak.citra-emu.org/
flatpak install https://flatpak.citra-emu.org/citra-canary.flatpakref

#flatpak --user install flathub jp.yvt.OpenSpades

#flatpak --user remote-add tingping https://dl.tingping.se/flatpak/tingping.flatpakrepo
#flatpak --user install tingping net.rpcs3.RPCS3