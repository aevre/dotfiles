# Shared Neovim plugin rules

These rules apply to the mapped Neovim plugin repositories. They override conflicting global instructions, while each repository's project-specific rules override conflicting rules here. Preserve all compatible broader rules.

- Preserve documented public APIs and existing runtime behavior unless the user explicitly requests a breaking change.
- Keep one guarded `plugin/<name>.lua` bootstrap; reusable behavior belongs under `lua/<name>/`.
- `setup()` must remain safe when called again with user options.
- Keep Lua 5.1/LuaJIT compatibility and the repository's stated minimum Neovim version.
- Do not mutate caller-owned option tables unexpectedly.
- Timer, request, window, autocmd, and scheduled-callback cleanup must be safe and idempotent; delayed callbacks revalidate objects.
- Use existing local dependencies and abstractions before adding code or dependencies.
- Run `make check`; it is the authoritative aggregate target and normally includes formatting, lint, tests, and health checks. Use narrower targets only while debugging.
- Add focused headless coverage for non-trivial lifecycle, parser, storage, or layout changes. Manually verify terminal UI behavior that headless tests cannot prove.
- Do not commit generated files, local `.luarc.json`, `.pi/`, credentials, histories, caches, or unrelated user configuration.
