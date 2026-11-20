# win.nvim

Shared dependency-free window object used by terminal, LazyGit, and notification plugins. Supports Neovim 0.9+; footers require 0.10+.

## Structure and API

- `plugin/win.lua`: guarded bootstrap; `lua/win/health.lua`: health provider.
- `init.lua`, `config.lua`, `style.lua`, `window.lua`, `buffer.lua`, `layout.lua`, `keys.lua`, `appearance.lua`, and `types.lua` own their named concerns.
- Preserve callable `Win(opts)`, `Win.new`, `Win.setup`, `Win.resolve`, `Win.style`, `Win.zindex`, and style `add/get`.
- Preserve common object methods including `show`, `hide`, `close`, `destroy`, `toggle`, `focus`, `valid`, `update`, `size`, `dim`, `set_buf`, `set_title`, `on`, and `toggle_help`, plus mapping/action behavior.
- Functional modules own their types. Methods receiving a window use explicit `self: win`; do not label module tables as instances.

## Invariants

- Keep the plugin dependency-free.
- Do not conflate window `winblend` with backdrop `blend`. `winhighlight` accepts native strings and mapping tables; native options still require documented Neovim types.
- Preserve buffer ownership: `close()` may wipe plugin-owned scratch buffers, `hide()` retains them, and user-provided buffers are never wiped accidentally.
- Keep float/split/current positioning, resize behavior, `enter`, `focusable`, callbacks, same-side stacking, and split equalization stable.

## Verification

Run `make check`. Lifecycle/layout coverage should include open, hide, reopen, close, resize, backdrop, user buffers, `focusable=false`, same-side stack placement, and equalized sizes.
