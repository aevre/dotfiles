# cmdline.nvim

Neovim 0.12+ UI2 renderer for command-line input, popup completion, and ordinary messages.

## Structure and API

- `plugin/cmdline.lua`: guarded bootstrap; `lua/cmdline/health.lua`: health provider.
- `init.lua` owns UI2 attachment/dispatch; `commandline.lua`, `popupmenu.lua`, `messages.lua`, `extensions.lua`, `ui.lua`, `config.lua`, and `highlights.lua` own their named concerns.
- Preserve `setup`, `disable`, `close_history`, and grouped `cmdline`, `messages`, and `popupmenu` configuration.
- User extensions run before built-ins, then fall back to `cmdline`; unmatched prompts use `input`. Keep search, input, rename, expression, debug, Lua, filter, help, and substitute contexts.

## UI2 and lifecycle invariants

- Own UI2 through `vim.ui_attach()` with `ext_cmdline`, `ext_popupmenu`, and `ext_messages`; do not use `vim._core.ui2.enable()`.
- Blink or nvim-cmp owns completion when present; do not draw a duplicate popupmenu.
- UI2 callbacks may be fast events. Schedule UI work and option access; direct option reads can raise E5560.
- Preserve zero `cmdheight` baseline, one-row `mini`, generation guards, concealed-prefix cursor compensation, multibyte coordinates, nested command lines, resize handling, and popup placement.
- `disable()` must detach UI2, remove autocmds, close windows, and restore `cmdheight`.
- History remains newest-first, scrollable, and separator-free; append entries merge while preserving embedded newlines.

## Search counts

- Consume `msg_show` kind `search_count` without forwarding it as an ordinary notification.
- `messages.view_search` defaults to `"notify"`; `false` disables search result/count presentation.
- Preserve count formatting/placement and `search_generation` guards. Esc/Ctrl-C clears cached state and suppresses late counts only for that event batch.
- While cached and `hlsearch` is enabled, monitor `vim.v.hlsearch` so `:nohlsearch` clears the extmark without cursor movement.
- Do not install a global Esc mapping.

## Verification

Run `make check`. Search changes cover fast-event dispatch, cancellation plus late count, `:nohlsearch`, and a later accepted search. Manually verify final geometry, cursor shape, completion coexistence, and highlights.
