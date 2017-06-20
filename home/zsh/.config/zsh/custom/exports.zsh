# shellcheck disable=2034,2148

# Keep a reasonably long history.
export HISTSIZE=800;

# Keep even more history lines inside the file, so we can still look up
# previous commands without needlessly cluttering the current shell's history.
export HISTFILESIZE=65536;

# When executing the same command twice or more in a row, only store it once.
# export HISTCONTROL=ignoredups;
# Ignore commands that start with spaces and duplicates
export HISTCONTROL=ignoreboth

# Keep track of the time the commands were executed.
# The xterm colour escapes require special care when piping; e.g. "| less -R".
export HISTTIMEFORMAT="${FG_BLUE}${FONT_BOLD}%Y/%m/%d %H:%M:%S${FONT_RESET}  ";

# Make some commands not show up in history.
export HISTIGNORE="ls:cd:cd:ll:ls:la:history -:pwd:exit:date:* --help";

# Make new shells get the history lines from all previous shells instead of the
# default "last window closed" history.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# To get rid of % on the end of the line
# https://superuser.com/questions/645599/why-is-a-percent-sign-appearing-before-each-prompt-on-zsh-in-windows/645612#645612
# https://unix.stackexchange.com/questions/167582/why-zsh-ends-a-line-with-a-highlighted-percent-symbol
export PROMPT_EOL_MARK=""

# W3M path
export W3MIMGDISPLAY_PATH="/usr/libexec/w3m/w3mimgdisplay"

# Ranger settings
export RANGER_LOAD_DEFAULT_RC=false

# ncmpcpp
export MPD_HOST="$XDG_RUNTIME_DIR/mpd/socket"

# for xdg-open
export BROWSER="torbrowser --allow-remote"

# gpg-agent-ssh
export GPG_TTY=$(tty)
unset SSH_AGENT_PID
#if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
#fi
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

# xdg
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export TASKDATA="$XDG_DATA_HOME/taskwarrior"
export TASKRC="$XDG_CONFIG_HOME/taskwarriorrc"
export TORSOCKS_CONF_FILE="$XDG_CONFIG_HOME/torsocks.conf"
export PROXYCHAINS_CONF_FILE="$XDG_CONFIG_HOME/proxychains.conf"
