if not functions -q fisher
  curl https://git.io/fisher --create-dirs -sLo $HOME/.config/fish/functions/fisher.fish
  fish -c fisher
end
#for sh in /etc/profile.d/*.sh
#  test -r $sh && bass source $sh
#end
source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/functions.fish
source $HOME/main/Documents/private.shell

# path
set PATH $PATH $HOME/.local/bin /usr/sbin /sbin
# editor, for sudo
set -gx EDITOR codium -w
# browser, for xdg-open
set -gx BROWSER firefox

echo Hi sempai~
