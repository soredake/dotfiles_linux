#!/bin/bash
sudo eselect fontconfig disable {1..101}
sudo eselect fontconfig enable 51-local.conf 52-infinality.conf
sudo eselect infinality set ultimate-free
sudo eselect lcdfilter set ultimate
