# Zsh plugins
# Format: plugin path | installation command
typeset -a zsh_plugins=(
  "/usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh|paru -S zsh-vi-mode"
  "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh|sudo pacman -S zsh-autosuggestions"
)

for entry in "${zsh_plugins[@]}"; do
  plugin="${entry%%|*}"
  install_cmd="${entry#*|}"

  if [[ -r "$plugin" ]]; then
    source "$plugin"
  else
    print -u2 -- "zsh: plugin not found or unreadable: ${${plugin#*/plugins/}%%/*}"
    print -u2 -- "zsh: install with: $install_cmd"
  fi
done

# Load syntax highlighting last
plugin="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"
if [[ -r "$plugin" ]]; then
  source "$plugin"
else
  print -u2 -- "zsh: plugin not found or unreadable: ${plugin#*/plugins/}"
  print -u2 -- "zsh: install with: sudo pacman -S zsh-syntax-highlighting"
fi

unset entry plugin install_cmd zsh_plugins
