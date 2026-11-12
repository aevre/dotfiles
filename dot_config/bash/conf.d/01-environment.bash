[[ ${BASH_ENVIRONMENT_LOADED:-0} == 1 ]] && return
BASH_ENVIRONMENT_LOADED=1

# Shared shell secrets
# shellcheck source=/dev/null
[[ -r "$XDG_CONFIG_HOME/shell/secrets.sh" ]] && source "$XDG_CONFIG_HOME/shell/secrets.sh"

# Editor
if [[ -n ${SSH_CONNECTION:-} ]]; then
  export EDITOR=vim
else
  export EDITOR=nvim
fi

# Rust
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# Go
export GOPATH="$HOME/go"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"

# Neovide
export NEOVIDE_FORK=1

# PATH: add entries once, preserving their order.
for directory in "$HOME/.local/bin" "$GOPATH/bin" "$PNPM_HOME/bin"; do
  [[ :$PATH: == *":$directory:"* ]] || PATH="$directory:$PATH"
done
export PATH
unset directory
