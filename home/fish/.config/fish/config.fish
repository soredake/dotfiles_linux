if not functions -q fisher
  curl https://git.io/fisher --create-dirs -sLo $HOME/.config/fish/functions/fisher.fish
  fish -c fisher
end
# https://github.com/fish-shell/fish-shell/issues/5117
if status is-login
for sh in /etc/profile.d/*.sh
  test -r $sh && bass source $sh
end
# path
set PATH $PATH $HOME/.local/bin /usr/sbin /sbin
end
source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/functions.fish
source $HOME/main/Documents/private.shell

# editor, for sudo
set -gx EDITOR codium -w
# browser, for xdg-open
set -gx BROWSER firefox

echo Hi sempai~
