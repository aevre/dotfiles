# notify.nvim

Owns `vim.notify`, ordinary history, event bus, floating rendering/queues, and optional Fidget-style messages and LSP progress. Depends on `win.nvim` and `animate.nvim`.

## Structure and API

- `plugin/notify.lua`: guarded bootstrap; `lua/notify/health.lua`: health provider.
- Core modules own notifications, bus, Fidget/LSP, text, levels, and utilities. `lua/notify/integrations/` contains picker backends for fzf-lua, Telescope, and `vim.ui.select`.
- Preserve callable `notify`, `vim.notify`, `setup`, `restore`, `history`, `clear_history`, `dismiss`, `send`, `emit`, `subscribe`, `unsubscribe`, `setup_progress`, `picker`, `bus`, and `notify.fidget` APIs.
- Records retain compatible `id`, `level`, `title`, and `message`; ordinary and Fidget histories stay separate.

## Invariants

- Requiring `notify` alone must not install handlers; bootstrapping belongs in `plugin/notify.lua`.
- Fast-event producers schedule enqueue/render work before touching UI state.
- Repeated `setup()` cleanly rebuilds bus subscriptions and resize autocmds. `restore()` restores `vim.notify`, LSP/Fidget hooks, autocmds, and bus subscriptions.
- Routes are ordered and first-match; do not add hidden compatibility/interception layers.
- Queue limits never evict visible records; later records wait in arrival order.
- Picker backends load lazily, use public history APIs, keep raw records for preview/copy, expose searchable text, and copy the selected message.
- `fade` uses color interpolation with `winblend = 0`; `fade_in_slide_out` combines fade and width movement. Keep generated highlight groups synchronized.
- Spinner frames are non-empty; intervals are milliseconds clamped to at least 50ms.
- Preserve Markdown markers with `conceallevel = 0` and existing renderer/stage names.

## Verification

Run `make check`. Picker changes cover all three backends, both histories, formatting, preview, and copying. Lifecycle changes cover fast-event enqueue, repeated setup, restore, replacement/deduplication, queues, timers, and invalid windows. Manually inspect animations, geometry, picker interaction, and theme/parser-dependent highlights.
