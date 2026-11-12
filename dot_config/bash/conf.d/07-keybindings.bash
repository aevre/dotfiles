# Flyline owns line editing when loaded. Keep these as Readline fallbacks.
if enable -p 2>/dev/null | grep -qx 'enable flyline'; then
  if declare -F __fzf_history__ fzf-file-widget __fzf_cd__ >/dev/null; then
    flyline_fzf_cd() {
      local cmd
      cmd=$(__fzf_cd__) && READLINE_LINE="$cmd" READLINE_POINT=${#cmd}
    }

    flyline key bind Ctrl+r 'always=runBashCommand(__fzf_history__)'
    flyline key bind Ctrl+t 'always=runBashCommand(fzf-file-widget)'
    flyline key bind Alt+c 'always=runBashCommand(flyline_fzf_cd)+submitOrNewline'
  fi
else
  set -o vi
  bind 'set completion-ignore-case on'
  bind 'set show-all-if-ambiguous on'
  bind 'set menu-complete-display-prefix on'
  bind '"\e[A": history-search-backward'
  bind '"\e[B": history-search-forward'
fi
