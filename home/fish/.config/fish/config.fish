# https://github.com/fish-shell/fish-shell/issues/5117#issuecomment-409506135
if status --is-login
  if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $__fish_config_dir/functions/fisher.fish
    fish -c fisher
  end
  bass source /etc/profile
  bass source $HOME/.profile
  echo Hi sempai~
end
set -gx EDITOR "code -w"
# nvme settings
set -gx DXVK_LOG_PATH none
# https://bugs.launchpad.net/ubuntu/+source/kubuntu-meta/+bug/1886018
set -gx GTK_USE_PORTAL 1
# vaapi
set -gx MOZ_X11_EGL 1
# wayland
#set -gx MOZ_ENABLE_WAYLAND 1

# Shorter
alias cps 'rsync --archive --compress --progress --verbose --executability -h --update --delete'
alias e 'code'
alias exip 'curl -s https://ipecho.net/plain'
alias fd 'fdfind'
alias g 'git'
alias iaupload 'ia upload --no-derive --checksum --verify --retries 10 -H x-archive-keep-old-version:0'
alias nvmestats 'sudo smartctl -A /dev/nvme0'
alias sc 'systemctl'
alias scu 'systemctl --user'
alias letyshops 'fxlowmem.sh -p $HOME/Documents/fxprofiles/letyshops -l /usr/bin'
#alias tlg2 'telegram-desktop -many -workdir $HOME/.local/share/TelegramDesktop2'
alias vts 'echo vitetris --connect (exip):27015 && vitetris -listen 27015'

function updatecleanup
  ubuntu-security-status --unavailable
  sudo apt autoremove
end

function speak
  trans -speak -s ru $argv -download-audio-as $XDG_RUNTIME_DIR/trans-speak.ts
  ffmpeg -y -i $XDG_RUNTIME_DIR/trans-speak.ts $XDG_RUNTIME_DIR/trans-speak.ogg
  echo $XDG_RUNTIME_DIR/trans-speak.ogg | xclip -i -selection clipboard
end
