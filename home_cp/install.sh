#!/bin/bash

SD="$(cd "$(dirname "$0")" > /dev/null || exit 1; pwd)";
cd "$SD" || exit 1

cp "$SD/firefox/user.js" "$HOME/.mozilla/firefox/tor-main/user.js"
cp "$SD/firefox/userChrome.css" "$HOME/.mozilla/firefox/tor-main/chrome/userChrome.css"