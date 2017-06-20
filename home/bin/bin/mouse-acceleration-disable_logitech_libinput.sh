#!/bin/bash
# https://www.reddit.com/r/linux_gaming/comments/535ng5/how_to_disable_mouse_acceleration_with_libinput/
for id in $(xinput|grep -E "Logitech USB Receiver.*pointer"|awk '{print $6}'|sed 's/id=//'); do xinput --set-prop "$id" "libinput Accel Profile Enabled" 0, 1 && echo "Mouse acceleration for $id set to 1"; done && echo "mouse sensetivity set to 0" && xset m 0/0 0 && echo "xset sensetivity set to 0"

#xset mouse 2 0
