# =========================
# fzf
# =========================
if (($+commands[fzf])); then
  source /usr/share/fzf/completion.zsh
  source /usr/share/fzf/key-bindings.zsh
fi

# =========================
# Tool Initialization
# =========================

# Starship
if (($+commands[starship])); then
  eval "$(starship init zsh)"
fi

# Zoxide
if (($+commands[zoxide])); then
  eval "$(zoxide init zsh)"
fi

# Mise
if (($+commands[mise])); then
  eval "$(mise activate zsh)"
  eval "$(mise completion zsh)"
fi
