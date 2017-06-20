#!/bin/bash
# https://www.linux.org.ru/forum/admin/10900964?lastmod=1455963299068#comment-10910753
# https://github.com/graysky2/profile-sync-daemon/issues/187
# https://github.com/systemd/systemd/blob/master/factory/etc/pam.d/system-auth#L11
sudo sed -i -e "\$a session		required	pam_systemd.so" -e '/pam_systemd.so/d' /etc/pam.d/system-auth
