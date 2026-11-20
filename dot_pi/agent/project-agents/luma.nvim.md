# luma.nvim

Neovim 0.10+ LLM client for streaming chat, models, history, context, optional Tavily search, guarded rewrites, and generic user tools.

## Structure and API

- `plugin/luma.lua`: guarded bootstrap; `lua/luma/health.lua`: health provider.
- Core modules own configuration/models, provider parsing/request lifecycle, session/UI/tool chats/tools, context/history/web, guarded diff, and scroll tracking.
- Preserve `setup`, `toggle`, `submit`, `cancel`, `new`, `resend`, `history`, `history_delete`, `history_clear`, `model`, `tool`, and runtime `:Luma*` commands.
- Preserve tool registry `register`, `unregister`, `get`, `names`, `run`, `setup` and context methods `visual`, `source`, `generate`, `chat`, `cancel`, `loading`, `panel`, `strip_fence`.
- `ctx.generate()` supports named fields `title`, `system`, `user`, `model`, `loading`, `window`, `editable`, `history`, `history_max`, `on_done`, and `on_error`.
- Declarative tools use `source`, `input_title`, `instruction`, and `run`; do not restore removed aliases.

## Security and behavior invariants

- Keep `win.nvim` and `animate.nvim`; do not add NUI, Plenary, or another HTTP client. Requests use `vim.system` and `curl`.
- Core provides mechanisms, not concrete Translate/Commit/Bash semantics; concrete tools stay in user config or examples.
- Preserve OpenAI-compatible and Ollama backends. `[DONE]` ends OpenAI streams; `finish_reason` must not discard remaining data.
- Append streaming output to the active Assistant tail and preserve manual scroll position.
- Preserve coordinated Chat, Prompt, Models, and History windows, group navigation/close, and source option restoration.
- Loading windows never modify source buffers. Keep distinct pending/result borders and overridable default highlight links.
- Tool-chat model/history remain isolated from the main session. A tool group has one footer: Prompt owns it.
- Guard rewrites with buffer identity, range bounds, and `changedtick`.
- History delete/clear accepts named scopes only; never turn scope names into arbitrary filesystem paths.
- Treat generated shell/Git actions as untrusted: show output first and require explicit execution.
- Keep credentials, authorization headers, complete prompts, and generated content out of persisted history, notifications, diagnostics, and examples.

## Documentation and verification

Keep `README.md`, `README.zh-CN.md`, and `docs/api.md` aligned. Concrete tools stay in `examples/tools.lua`; docs state input, behavior, result, and side effects.

Run `make check`. Parser changes cover streaming/non-streaming, partial lines, `[DONE]`, errors, cancellation, and cleanup. UI/tool changes cover navigation, restoration, scroll retention, selection attachment, isolation, footer ownership, borders, model precedence, callbacks, history scopes, and guarded diffs. Manually inspect terminal UI and live providers.
