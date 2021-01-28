#!/bin/bash
export WINEESYNC=1
#export EDITOR="code -w" # https://bugs.kde.org/show_bug.cgi?id=393812
# https://bugs.launchpad.net/ubuntu/+source/kubuntu-meta/+bug/1886018
# https://bugzilla.mozilla.org/show_bug.cgi?id=1658011
# https://invent.kde.org/neon/neon/settings/-/blob/Neon/unstable/usr/sbin/firefox#L7
export GTK_USE_PORTAL=1
# https://github.com/nodesource/distributions/issues/1141
# https://www.opennet.ru/opennews/art.shtml?num=54402
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=980316
export NODE_PATH=/usr/lib/nodejs:/usr/share/nodejs
# ipega sdl bindings
# https://bugzilla.libsdl.org/show_bug.cgi?id=5243
#export SDL_GAMECONTROLLERCONFIG="05000000491900000204000000000000,Ipega PG-9087S - Bluetooth Gamepad,a:b0,b:b1,y:b4,x:b3,start:b11,back:b10,leftstick:b13,rightstick:b14,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b8,righttrigger:b9,platform:Linux,"
