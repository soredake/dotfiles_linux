if not functions -q fisher
  curl https://git.io/fisher --create-dirs -sLo $__fish_config_dir/functions/fisher.fish
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
source $__fish_config_dir/aliases.fish
source $__fish_config_dir/functions.fish
source $HOME/main/Documents/private.shell

# editor, for sudo
set -gx EDITOR codium -w
# browser, for xdg-open
set -gx BROWSER firefox

echo Hi sempai~