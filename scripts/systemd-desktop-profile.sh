#!/bin/bash

p='/usr/portage/profiles/default/linux/amd64/17.0/desktop/systemd'
sudo mkdir -p $p
sudo sed -i 's|.*amd64           default/linux/amd64/13.0/desktop                   stable.*|&\namd64           default/linux/amd64/17.0/desktop/systemd           stable|' /usr/portage/profiles/profiles.desc
sudo tee $p/eapi >/dev/null <<< "5"
sudo tee $p/parent >/dev/null <<END
..
../../../../../../targets/systemd
END
