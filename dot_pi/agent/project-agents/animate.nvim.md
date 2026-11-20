# animate.nvim

Small dependency-free numeric animation engine for Neovim 0.10+.

## Structure and API

- `plugin/animate.lua`: guarded bootstrap; `lua/animate/health.lua`: health provider.
- `lua/animate/init.lua`: callable API and exports; `animation.lua`, `state.lua`, `easing.lua`, `config.lua`, and `types.lua` own their named concerns.
- Preserve `setup`, `add`, `del`, `enabled`, public `Animation` and `easing` exports, and callable `require("animate")(from, to, callback, opts)`.
- Callbacks receive `(value, ctx)`; `ctx.done` is true on the final callback. Reusing an `id` stops the previous animation.

## Invariants

- Keep the plugin dependency-free.
- Preserve buffer/global `core_animate*` switches and `int` rounding behavior.
- A numeric duration and `duration.step` are milliseconds per animated unit; `duration.total` is the total-duration cap. Do not conflate them.
- Timer cancellation and cleanup remain idempotent; scheduled callbacks tolerate stopped animations.

## Verification

`make check` is authoritative. Behavior changes need deterministic assertions in `tests/smoke.lua` when practical; wall-clock animation feel still needs an interactive check.
