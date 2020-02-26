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

# Set default programs
# no valid MANPAGER pager is set lead to https://bbs.archlinux.org/viewtopic.php?id=178730 
#export MANPAGER=less
# editor
export EDITOR=codium
# browser for xdg-open
export BROWSER=firefox

# zsh-autosuggest plugin settings
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20