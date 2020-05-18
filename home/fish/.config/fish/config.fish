# https://github.com/fish-shell/fish-shell/issues/5117
if status --is-login
  if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $__fish_config_dir/functions/fisher.fish
    fish -c fisher
  end
  for sh in /etc/profile.d/*.sh; test -r $sh && bass source $sh; end
  set -gx PATH $PATH $HOME/.local/bin
  echo Hi sempai~
end
set -gx EDITOR "code -w"
source $__fish_config_dir/stuff.fish