# History
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export HISTFILE="$XDG_STATE_HOME/bash/history"
export HISTSIZE=100000
export HISTFILESIZE=100000
mkdir -p "${HISTFILE%/*}" || printf 'bash: cannot create history directory: %s\n' "${HISTFILE%/*}" >&2

HISTCONTROL=ignoreboth:erasedups
HISTIGNORE='&:[ ]*'
shopt -s histappend cmdhist checkwinsize

# Append new commands and read commands written by other sessions.
__bash_sync_history() {
  builtin history -a
  builtin history -n
}
PROMPT_COMMAND="__bash_sync_history${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

# Completion
shopt -s progcomp
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  # shellcheck source=/dev/null
  source /usr/share/bash-completion/bash_completion
elif [[ -r /etc/bash_completion ]]; then
  # shellcheck source=/dev/null
  source /etc/bash_completion
fi
