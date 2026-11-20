# scroll.nvim

Smooth vertical and horizontal cursor movement using `animate.nvim` while preserving native scrolling, for Neovim 0.10+.

## Structure and API

- `plugin/scroll.lua`: guarded bootstrap; `lua/scroll/health.lua`: health provider.
- `init.lua`, `config.lua`, `state.lua`, and `types.lua` own API/scrolling, options, per-window state, and types.
- Preserve `setup`, `enable`, `disable`, `check`, and `debug`.
- `setup()` enables unless `enabled = false`. `filter(buf)` is one eligibility input, alongside paste/recording/execution state and `core_scroll`/`core_animate` switches.

## Invariants

- Reuse `animate.nvim`; do not add another timer or easing implementation.
- Keep terminal buffers excluded by default.
- Stop animation and restore options when state becomes invalid, windows close, buffers change, paste/recording/execution disables animation, switches change, or the plugin is disabled.
- Preserve native scroll command behavior and existing integration mappings.

## Verification

Run `make check`; the local test setup expects sibling `../animate.nvim`. `tests/recording.lua` and related headless coverage should protect recording, paste, global/buffer switches, buffer replacement, and window lifecycle.
