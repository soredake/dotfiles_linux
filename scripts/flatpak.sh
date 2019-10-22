#!/bin/bash
#flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# https://github.com/TingPing/flatpak-packages/issues/11
#flatpak --user remote-add tingping https://dl.tingping.se/flatpak/tingping.flatpakrepo
#flatpak --user install tingping net.lutris.Lutris

# https://neverware.zendesk.com/hc/en-us/community/posts/360002990188-Flatpak-doesn-t-work-What-s-wrong
# to avoid `error: No remote refs found similar to ‘flathub’`
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#flatpak --user install flathub jp.yvt.OpenSpades
