# shellcheck disable=2034,2148

# https://github.com/zdharma/zplugin#customizing-paths
declare -A ZPLGM  # initial Zplugin's hash definition, if configuring before loading Zplugin, and then:
ZPLGM[BIN_DIR]="$XDG_DATA_HOME/zplugin/bin"
ZPLGM[HOME_DIR]="$XDG_DATA_HOME/zplugin"
ZPFX="$XDG_DATA_HOME/zplugin/polaris"
ZPLGM[COMPINIT_OPTS]=-C
[[ ! -d "${ZPLGM[BIN_DIR]}" ]] && git clone --depth 10 https://github.com/zdharma/zplugin.git "${ZPLGM[BIN_DIR]}"
### Added by Zplugin's installer
# shellcheck disable=1090
source "${ZPLGM[BIN_DIR]}/zplugin.zsh"
autoload -Uz _zplugin
# shellcheck disable=2154
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk
# shellcheck disable=1090
zplugin light zsh-users/zsh-autosuggestions
zplugin snippet OMZ::lib/completion.zsh
zplugin snippet OMZ::lib/directories.zsh
zplugin snippet OMZ::lib/history.zsh
zplugin snippet OMZ::lib/key-bindings.zsh
zplugin snippet OMZ::lib/theme-and-appearance.zsh
zplugin snippet OMZ::plugins/extract/extract.plugin.zsh
# Load the pure theme, with zsh-async library that's bundled with it
zplugin ice pick"async.zsh" src"pure.zsh"; zplugin light sindresorhus/pure
  
# https://github.com/zdharma/zplugin#calling-compinit-without-turbo-mode
# https://unix.stackexchange.com/a/178054
unsetopt complete_aliases
autoload -Uz compinit
compinit
# shellcheck disable=1090
zplugin cdreplay -q
# syntax-highlighting plugins (like fast-syntax-highlighting or zsh-syntax-highlighting) expect to be loaded last
zplugin light zdharma/fast-syntax-highlighting

# shellcheck disable=1090
for f in "$XDG_CONFIG_HOME/zsh/custom"/*; do . "$f"; done

# Add additional directories to the path.
# https://github.com/yarnpkg/yarn/issues/5353
pathadd() {
  [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] && PATH="${PATH:+"$PATH:"}$1"
}
pathadd "$HOME/bin"
pathadd /sbin
pathadd /usr/sbin
#pathadd "$(yarn global bin)"

# enable completion for hidden f{iles,olders}
# https://unix.stackexchange.com/questions/308315/how-can-i-configure-zsh-completion-to-show-hidden-files-and-folders
_comp_options+=(globdots)

# read private and global profile files
# shellcheck disable=1090
for f in "$XDG_DATA_HOME"/private/*; do . "$f"; done
for sh in /etc/profile.d/*.sh ; do
        #shellcheck disable=1090
        [[ -r "$sh" ]] && . "$sh"
done
unset sh

# use language set from plasma
# shellcheck disable=1090
. "$HOME/.config/plasma-locale-settings.sh"

# Don't hash directories on the path a time, which allows new
# binaries in $PATH to be executed without rehashing.
setopt nohashdirs

# No global match, no more "zsh: not found"
unsetopt nomatch

# Not autocomplete /etc/hosts, https://unix.stackexchange.com/questions/14155/ignore-hosts-file-in-zsh-ssh-scp-tab-complete
zstyle ':completion:*:hosts' hosts off

# Make zsh know about hosts already accessed by SSH
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/common-aliases/common-aliases.plugin.zsh#L86
# shellcheck disable=2016
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh
# Not complete . and .. special directories
zstyle ':completion:*' special-dirs false
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/misc.zsh#L34
# recognize comments
setopt interactivecomments

# Quote stuff that looks like URLs automatically.
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/misc.zsh
autoload -Uz bracketed-paste-magic
autoload -U url-quote-magic
zstyle ':urlglobber' url-other-schema ftp git gopher http https magnet
zstyle ':url-quote-magic:*' url-metas "*&?[]^'(|)~#="
zle -N self-insert url-quote-magic
zle -N bracketed-paste bracketed-paste-magic

echo Hi sempai~
