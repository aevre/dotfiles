# session.nvim

Neovim 0.12+ project-session manager based on native `:mksession` and `:source`. Do not add dependencies, a separate index, or custom editor-state serialization.

## Structure and API

- `plugin/session.lua`: guarded bootstrap; `lua/session/health.lua`: health provider.
- `init.lua`, `config.lua`, `project.lua`, `storage.lua`, `manager.lua`, `commands.lua`, and `types.lua` own lifecycle/API, options, root detection, persistence, operations, commands, and types.
- Preserve `setup`, `save`, `load`, `select`, `last`, `list`, `active`, `delete`, `delete_select`, `rename`, and `rename_select`.
- Preserve `SessionInfo`, `SessionSelect`, `SessionLast`, `SessionSave[!] [name]`, `SessionLoad [name]`, `SessionDelete[!] [name]`, `SessionDeleteSelect`, `SessionRename[!] [old] [new]`, and `SessionRenameSelect`.

## Invariants

- Session identity is project root plus optional name; omitted means `default`. Keep active identity fixed after load/save even if cwd changes.
- Respect current `sessionoptions`; do not filter or rewrite native session contents.
- Read metadata for discovery but never source a session while listing.
- Prompt before replacing a workspace containing modified named file buffers.
- Keep saves atomic using temporary-file plus rename. Validate names before path construction.
- Keep full SHA-256 root hashes in filenames and JSON metadata in the leading Vimscript comment.
- Preserve graceful errors and clean temporary files after failed operations.
- Preserve `auto_restore`, exit autosave, and `autosave_on_switch` lifecycle semantics without duplicate autocmds.

## Verification

Run `make check` and keep LuaLS warnings clean. `tests/session.lua` should cover overwrite, load, repeated setup, Info, delete/rename, active identity, exit autosave, and selection flows. Add focused coverage when changing auto-restore, switch autosave, dirty-buffer confirmation, atomic failures, or temporary-file cleanup.
