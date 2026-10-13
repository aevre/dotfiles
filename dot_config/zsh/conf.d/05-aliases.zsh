# =========================
# Aliases
# =========================

# Listing
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -lh'

# Editor
alias n='nvim'
alias zshconfig='${EDITOR:-nvim} ~/.config/zsh'
alias reload='source ~/.config/zsh/.zshrc'

# Navigation
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Sudo
alias sd='sudoedit'

# Git
alias gc='git clone'
alias gs='git status'
alias ga='git add'
alias gcmsg='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Safety
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

# =========================
# Functions
# =========================

# Neovide: fork into background
if (($+commands[neovide])); then
  neovide() {
    command neovide --fork "$@"
  }
fi
