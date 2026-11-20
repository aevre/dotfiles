# lazygit.nvim

Thin LazyGit integration built on `terminal.nvim` -> `win.nvim`, supporting Neovim 0.10+.

## Structure and API

- `plugin/lazygit.lua`: guarded bootstrap; `lua/lazygit/health.lua`: health provider.
- `init.lua`, `config.lua`, `env.lua`, `theme.lua`, and `types.lua` own launch/API, options, config discovery, generated theme YAML, and types.
- Preserve `setup`, `open`, `log`, `log_file`, callable `require("lazygit")`, and per-call option precedence.

## Invariants

- Keep terminal/window lifecycle in dependencies; do not add another implementation.
- Never overwrite the user's LazyGit config. Preserve existing `LG_CONFIG_FILE` entries and append the generated config path as current code does.
- Generated config/theme is written on first open and on the next open after `ColorScheme` or `ThemeApply` marks it dirty; do not claim eager startup regeneration.
- Keep graceful errors when LazyGit or config discovery is unavailable.
- Treat shell arguments, current-file paths, unnamed buffers, and cwd selection carefully.

## Verification

Run `make check`. Keep pure command/theme/config behavior headless; do not require the LazyGit executable in tests. Manually verify changed command arguments and working-directory behavior.
