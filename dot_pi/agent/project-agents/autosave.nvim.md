# autosave.nvim

Dependency-free per-buffer trailing autosave for Neovim 0.12+.

## Structure and API

- `plugin/autosave.lua`: guarded bootstrap; `lua/autosave/health.lua`: health provider.
- `lua/autosave/init.lua`, `config.lua`, `save.lua`, `timer.lua`, and `types.lua` own API/lifecycle, options, writes, debounce timers, and types.
- Preserve `setup`, `enable`, `disable`, `toggle`, `is_enabled`, and `save`; `save(buf?)` returns whether a write occurred.

## Invariants

- Preserve trailing per-buffer debounce, generation guards, and cleanup when buffers are deleted or wiped.
- Save only named, loaded, modified, modifiable, non-readonly normal file buffers.
- Run user filters after built-in eligibility checks. Filter and write failures remain visible through `vim.notify()`.
- Repeated setup must replace lifecycle state cleanly without duplicate autocmds or timers.

## Verification

Run `make check`. `tests/autosave.lua` should cover debounce generations, lifecycle cleanup, eligibility, filters, repeated setup, and explicit saves; use no external interactive programs.
