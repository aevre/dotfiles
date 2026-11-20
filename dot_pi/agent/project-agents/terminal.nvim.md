# terminal.nvim

Reusable terminal buffers/windows delegated to `win.nvim`, supporting Neovim 0.10+.

## Structure and API

- `plugin/terminal.lua`: guarded bootstrap; `lua/terminal/health.lua`: health provider.
- `init.lua`, `config.lua`, `style.lua`, `terminal.lua`, `registry.lua`, `util.lua`, and `types.lua` own API, options, window style, process lifecycle, reuse, parsing/colorization, and types.
- Preserve callable module plus `setup`, `open`, `get`, `list`, `select`, `toggle`, `focus`, `tid`, `parse`, and `colorize`.
- Reuse identity includes command, cwd, environment, and count. Per-call options override setup defaults.

## Invariants

- Keep `win.nvim` as the window abstraction; do not add another.
- Generic float highlight defaults belong in the plugin; personal `Terminal*` links belong in consumer configuration.
- Start/auto-insert and successful-process auto-close remain enabled unless disabled.
- Non-zero exits remain visible as errors; cleanup removes dead terminals from the registry.
- `parse()` preserves quoted spaces and supports `\"` and `\\` inside double quotes; do not claim general shell escaping such as `a\ b` unless implemented and tested.

## Verification

Run `make check`. Keep `tests/style.lua` passing; add focused assertions before changing parsing, reuse identity, exit handling, auto-close, or registry cleanup. External interactive programs should not be required by headless tests; final rendering needs a real terminal.
