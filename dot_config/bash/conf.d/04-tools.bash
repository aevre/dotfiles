# fzf
if [[ -r /usr/share/fzf/completion.bash ]]; then
  # shellcheck source=/dev/null
  source /usr/share/fzf/completion.bash
fi
if [[ -r /usr/share/fzf/key-bindings.bash ]]; then
  # shellcheck source=/dev/null
  source /usr/share/fzf/key-bindings.bash
fi

# Starship
if command -v starship >/dev/null 2>&1; then
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
  eval "$(starship init bash)"
fi

# Zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# Mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
  eval "$(mise completion bash)"
fi
