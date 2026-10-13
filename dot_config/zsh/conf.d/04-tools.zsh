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
