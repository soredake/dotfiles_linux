# https://github.com/fish-shell/fish-shell/issues/5117#issuecomment-409506135
if status --is-login
  if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $__fish_config_dir/functions/fisher.fish
    fish -c fisher
  end
  bass source /etc/profile
  bass source $HOME/.profile
  #set -gx PATH $PATH $HOME/.local/share/npm/bin
  echo Hi sempai~
end
set -gx EDITOR "code -w"
# https://bugs.launchpad.net/ubuntu/+source/kubuntu-meta/+bug/1886018
# https://bugzilla.mozilla.org/show_bug.cgi?id=1658011
# https://invent.kde.org/neon/neon/settings/-/blob/Neon/unstable/usr/sbin/firefox#L7
set -gx GTK_USE_PORTAL 1
# https://bugzilla.mozilla.org/show_bug.cgi?id=788319
#set -gx MOZ_X11_EGL 1
# https://github.com/nodesource/distributions/issues/1141
set -gx NODE_PATH /usr/lib/nodejs:/usr/share/nodejs
# https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/telling-git-about-your-signing-key
#set -gx GPG_TTY (tty)
# ipega sdl bindings
set -gx SDL_GAMECONTROLLERCONFIG "05000000491900000204000000000000,Ipega PG-9087S - Bluetooth Gamepad,a:b0,b:b1,y:b4,x:b3,start:b11,back:b10,leftstick:b13,rightstick:b14,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpleft:h0.8,dpdown:h0.4,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b8,righttrigger:b9,platform:Linux,"
# wine env
set -gx WINEESYNC 1
set -gx WINEFSYNC 1

# Shorter
alias e 'code'
alias exip 'curl -s https://ipecho.net/plain'
alias fd 'fdfind'
alias g 'git'
alias iaupload 'ia upload --no-derive --checksum --verify --retries 10 -H x-archive-keep-old-version:0'
alias nvmestats 'sudo smartctl -A /dev/nvme0' # https://bugs.kde.org/show_bug.cgi?id=422877
alias synctomega 'rclone sync -P --exclude .overgrive\* $HOME/main 50gbmega:/main'
alias vts 'echo vitetris --connect (exip):27015 && vitetris -listen 27015'
alias yarn 'yarnpkg'

function updatecleanup
  ubuntu-security-status --unavailable
  sudo apt autoremove
end

function speak
  trans -speak -s ru $argv -download-audio-as $XDG_RUNTIME_DIR/trans-speak.ts
  ffmpeg -y -i $XDG_RUNTIME_DIR/trans-speak.ts $XDG_RUNTIME_DIR/trans-speak.ogg
  echo $XDG_RUNTIME_DIR/trans-speak.ogg | xclip -i -selection clipboard
end

# esc is broken
xmodmap ~/.Xmodmap

# https://gitlab.com/freedesktop-sdk/freedesktop-sdk/-/issues/1133
function freetypecleartype
  fd -t f -H -I "libfreetype.so*" --search-path /var/lib/flatpak -x sudo cp -fv (realpath /usr/lib/x86_64-linux-gnu/libfreetype.so.6) {}
  # fix `/app/extra/viber/Viber: error while loading shared libraries: libbrotlidec.so.1: cannot open shared object file: No such file or directory`
  # will be fixed by https://github.com/flathub/com.viber.Viber/pull/27
  #sudo cp -v /var/lib/flatpak/runtime/org.kde.Platform/x86_64/5.15/active/files/lib/x86_64-linux-gnu/libbrotli* /var/lib/flatpak/runtime/org.freedesktop.Platform/x86_64/19.08/active/files/lib/x86_64-linux-gnu
end
