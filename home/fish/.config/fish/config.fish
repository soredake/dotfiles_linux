# https://github.com/fish-shell/fish-shell/issues/5117#issuecomment-409506135
#if status --is-login
#  echo Hi sempai~
#end

# Alises
alias e 'code'
alias exip 'curl -s https://ipecho.net/plain'
alias fd 'fdfind'
alias g 'git'
alias iaupload 'ia upload --no-derive --checksum --verify --retries 10 -H x-archive-keep-old-version:0'
alias nvmestats 'sudo smartctl -A /dev/nvme0'
alias vts 'echo vitetris --connect (exip):27015 && vitetris -listen 27015'
alias yarn 'yarnpkg'

function updatecleanup
  ubuntu-security-status --unavailable
  sudo apt autoremove
end
