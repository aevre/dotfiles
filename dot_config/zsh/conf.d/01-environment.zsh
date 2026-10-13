# =========================
# Zsh Function Search Path
# =========================
typeset -U fpath
fpath=(/usr/share/zsh/site-functions $fpath)

# =========================
# Editor
# =========================
if [[ -n "$SSH_CONNECTION" ]]; then
  export EDITOR=vim
else
  export EDITOR=nvim
fi

# =========================
# Rust
# =========================
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# =========================
# Go
# =========================
export GOPATH="$HOME/go"

# =========================
# pnpm
# =========================
export PNPM_HOME="$HOME/.local/share/pnpm"

# =========================
# PATH
# =========================
typeset -U path
path=(
  "$PNPM_HOME/bin"
  "$GOPATH/bin"
  "$HOME/.local/bin"
  $path
)
export PATH
