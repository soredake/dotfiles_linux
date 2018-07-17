# shellcheck disable=2034,2148

# When executing the same command twice or more in a row, only store it once.
# Ignore commands that start with spaces and duplicates
export HISTCONTROL=ignoreboth

# To get rid of % on the end of the line
# https://superuser.com/questions/645599/why-is-a-percent-sign-appearing-before-each-prompt-on-zsh-in-windows/645612#645612
# https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
export PROMPT_EOL_MARK=""

# Ranger settings
export RANGER_LOAD_DEFAULT_RC=false

# for xdg-open
export BROWSER="firefox"

# xdg
# https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
export MPD_HOST="$XDG_RUNTIME_DIR/mpd/socket"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export PROXYCHAINS_CONF_FILE="$XDG_CONFIG_HOME/proxychains.conf"
export ATOM_HOME="$XDG_DATA_HOME/atom"
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android
