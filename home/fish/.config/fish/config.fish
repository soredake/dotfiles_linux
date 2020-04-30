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
set PATH $PATH $HOME/.local/bin
end
source $__fish_config_dir/stuff.fish

# editor, for sudo
set -gx EDITOR code -w
# browser, for xdg-open
set -gx BROWSER firefox

echo Hi sempai~