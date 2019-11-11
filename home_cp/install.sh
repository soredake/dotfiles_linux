#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

sudo cp "$SD/grub/grub" /etc/default/grub
sudo cp "$SD/dnscrypt-proxy/dnscrypt-proxy.toml" /etc/dnscrypt-proxy/dnscrypt-proxy.toml