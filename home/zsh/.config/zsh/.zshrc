# shellcheck disable=2034,2148
if [[ "$ZPLUG" == true ]]; then
  [[ ! -d "$XDG_DATA_HOME/zplug" ]] && git clone --depth 1 https://github.com/zplug/zplug "$XDG_DATA_HOME/zplug"
  export ZPLUG_HOME="$XDG_DATA_HOME/zplug"
  export ZPLUG_LOADFILE="$XDG_CONFIG_HOME/zsh/packages.zsh"
  export ZPLUG_CACHE_DIR="$XDG_CACHE_HOME/zplug"
  # shellcheck disable=1090
  . "$XDG_DATA_HOME/zplug/init.zsh"
  zplug "zdharma/fast-syntax-highlighting"
  zplug "zsh-users/zsh-autosuggestions"
  zplug 'sindresorhus/pure', as:theme, use:"*.zsh"
  zplug "lib/completion", from:oh-my-zsh
  zplug "lib/history", from:oh-my-zsh
  zplug "lib/key-bindings", from:oh-my-zsh
  zplug "lib/theme-and-appearance", from:oh-my-zsh
  zplug "plugins/extract", from:oh-my-zsh
  # https://github.com/Orochimarufan/.files/blob/1ade15c9069c2846b134860e56fbe9b97b1ed0bb/zsh/zshrc#L28
  # Install plugins if there are plugins that have not been installed
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
  fi

  # Then, source plugins and add commands to $PATH
  zplug load

  # Changing/making/removing directory
  setopt auto_pushd
  setopt pushd_ignore_dups
  setopt pushdminus

  alias -g ...='../..'
  alias -g ....='../../..'
  alias -g .....='../../../..'
  alias -g ......='../../../../..'

  alias 1='cd -'
  alias 2='cd -2'
  alias 3='cd -3'
  alias 4='cd -4'
  alias 5='cd -5'
  alias 6='cd -6'
  alias 7='cd -7'
  alias 8='cd -8'
  alias 9='cd -9'
  alias d='dirs -v | head -10'

  # List directory contents
  alias lsa='ls -lah'
  alias l='ls -lah'
  alias ll='ls -lh'
  alias la='ls -lAh'

  # shellcheck disable=1090
  for f in "$XDG_CONFIG_HOME/zsh/custom"/*; do . $f; done
fi

# Add additional directories to the path.
# https://github.com/yarnpkg/yarn/issues/5353
pathadd() {
  [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && PATH="${PATH:+"$PATH:"}$1"
}
pathadd "$HOME/bin"
pathadd /sbin
pathadd /usr/sbin
pathadd /snap/bin

# enable completion for hidden f{iles,olders}
# https://unix.stackexchange.com/questions/308315/how-can-i-configure-zsh-completion-to-show-hidden-files-and-folders
_comp_options+=(globdots)

# shellcheck disable=1090
for f in $HOME/.private/*; do . $f; done

# Don't hash directories on the path a time, which allows new
# binaries in $PATH to be executed without rehashing.
setopt nohashdirs

# No global match, no more "zsh: not found"
unsetopt nomatch

# Not autocomplete /etc/hosts, https://unix.stackexchange.com/questions/14155/ignore-hosts-file-in-zsh-ssh-scp-tab-complete
zstyle ':completion:*:hosts' hosts off

# https://stackoverflow.com/questions/14307086/tab-completion-for-aliased-sub-commands-in-zsh-alias-gco-git-checkout/20643204#20643204
setopt COMPLETE_ALIASES

# Less and xsel cannot create the needed folders
[[ ! -d "$XDG_CACHE_HOME/less" ]] && mkdir "$XDG_CACHE_HOME/less"
[[ ! -d "$XDG_CACHE_HOME/xsel" ]] && mkdir "$XDG_CACHE_HOME/xsel"

# clear terminal on exit
# or echo -e \\033c
#exithook() {
#  printf "\033c"
#}

# https://stackoverflow.com/questions/18221348/exit-hook-working-both-on-bash-and-zsh
# do not use a zsh way
#trap exithook EXIT

# Quote stuff that looks like URLs automatically.
# https://github.com/robbyrussell/oh-my-zsh/blob/3ed37f47cb1a9385e2238528839d7d91634f2c5b/lib/misc.zsh#L7-L9<Paste>
autoload -Uz bracketed-paste-magic
autoload -U url-quote-magic
zstyle ':urlglobber' url-other-schema ftp git gopher http https magnet
zstyle ':url-quote-magic:*' url-metas "*&?[]^'(|)~#="
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

echo Hi sempai~
