---
name: reforged-hitchance-overlay
description: Design decisions and pitfalls of Reforged's hit-chance overlay (labels beside opponents) and the movement-preview tile tooltip that shares its data. Use when changing, debugging, testing or tuning hitchance_overlay.nut, rf_hitchance_overlay.js/css or RF_getMovementPreviewTooltip.
---

# Reforged hit-chance overlay

Code: `mod_reforged/hitchance_overlay.nut` (`::Reforged.HitchanceOverlay`), `ui/mods/mod_reforged/rf_hitchance_overlay.js` + `css_hooks/screens/tactical/rf_hitchance_overlay.css`, `hooks/ui/screens/tooltip/tooltip_events.nut` (tile tooltip), `hooks/native/TacticalTile.nut` (preview tile properties). Settings: Tooltips page, `HitchanceDisplay_*` and `HitchanceOverlay_*`. Vanilla bar/marker geometry, projection and scales: `bb-ui-screen` skill, "Overlays over the map".

## When it shows (`getSubject`), decided with the user
Only on the player's turn, never during AI turns (also not for hovering). In this order:
1. **Skill selected:** only a hit-chance attack, only opponents it can target, from the bro's tile. Other skills show nothing (no generic way to know where e.g. Footwork moves him). Checked before hover, as aiming also sets `ActiveEntityMouseHover`.
2. **Hovered player bro** at his tile. Vanilla clears the hover on every tile change, so the labels vanish before the mouse reaches them: no linger, by choice.
3. **Move:** the tile clicked as movement target (`LastTileSelected` in `ComputePath`), not the hovered tile, so labels stay put while the mouse moves to them. It may lie beyond the affordable path end.

## Data
- `compute()` is the single source for overlay and tile tooltip; the tooltip reuses a current snapshot. When the tooltip needs only the attacks on movement, `computeZOCAttacks` skips the costly hit chances.
- **Movement preview** (`runMovementPreview`): the bro's `getTile()` returns the destination, tile properties make the destination occupied and the current tile empty and move his ZoC, terrain effects are swapped directly in `m.Skills`. Pitfalls:
  - Everything must be restored also after an error; a leftover switcheroo breaks the rest of the battle. It does its own MV preview updates (`doPreviewUpdate`) to reset MV's flags on errors.
  - Opponents that get a row are recalculated (`MV_doPreviewUpdate(false)`) *before* both halves: their defense can depend on the bro's position too.
  - The swapped-in terrain effect gets `m.Container` directly: `setContainer` has side effects through hooks.
- **Opponent attack** (setting): Primary = first attack in skill bar order that can reach the bro (default), or best hit chance.
- **Attacks on movement/arrival** follow vanilla `onAttackOfOpportunity`, including `onVerifyTarget` (`use()` checks it, e.g. height). By default (`HitchanceDisplay_ZOCAttacks` = Always) the tile tooltip lists them whatever the display settings: the user considers them more basic than the overlay. They add a warning to a label but create an opponent row only when opponents' chances are shown.
- Opponents out of sight get nothing; opponents that acted (`isTurnDone`) are dimmed and marked "(next turn)".

## Driver and pitfalls
- `onFrame` (from the `orientation_overlay.update` hook) recomputes on a subject key change, or when dirty, at most every `__RecomputeInterval`. Otherwise it only re-sends positions when the camera/travel key changes. An idle frame costs nothing.
- Dirty sources: `actor.setDirty`, `skill_container.update` (not MV preview updates), `initNextTurn`, setting callbacks. `IsComputing` stops our own updates from marking it dirty.
- A failing `compute` is logged once (`logError`, replaceable in tests), not retried every frame.
- Call callbacks via `bindenv(this)()`, not `.call()`: an error passing a native `call()` is logged as a script error even when caught.
- Hovering a label freezes the overlay (`IsFrozen`) so its tooltip matches. Hovered labels count as UI, so vanilla drops the hovered tile: labels are hoverable by default, key X inverts it.

## Placement decisions
- Beside (default): at the outer hex corner, right of opponents and left of allies, the top of the first row just below vanilla's bars. While the bars are hidden, the first row is centered at torso height instead: the spot below the bars is the base of the unit on the tile above and looked like its label. Smaller labels sit closer (corner factor linear in label size).
- Above: just above bars and status icons; it covers the unit on the tile above, hence not the default.
- Units above the camera level: beside or above their portrait marker.
- Sized like the map (`ReferenceUIScale / UIScale`), shrinking with zoom within limits. Verified at 4K, 1440p (UI 100/125/150%, scene 100/150%) and 1080p.
- `Vanilla` and `Layout` constants and `SideOffsetByType` are public for mods (other sprite sizes, restyled labels); `__` members are internal.

## Performance
- About 24 ms per move-preview recompute with 44 opponents (7 ms hover, 2 ms skill), mostly opponents' preview updates (~0.86 ms each, twice) and `getHitchance` (~0.4 ms each); both are needed.
- Rejected as fragile: updating only opponents near the bro (a skill may react from further away); spreading a recompute over frames (the switcheroo can't stay applied between frames).
- Benchmark: `bb_test.py --mod <workspace>\mod_reforged --filter bench [--save-bench]`. Its `FINGERPRINT` rows (all results) must stay identical when tuning; timings vary about ±10%.

## Tests (`tests/hitchance_overlay.nut`)
- Pin the settings a test depends on: the user's saved MSU settings apply during runs.
- An idle active bro shows nothing: display tests use a move preview (`previewMoveNextToEnemy`).
- Callbacks go in file-level helpers (functions inside a generator test can't read its locals).
- Fixed label data for screenshots: set `__State.Snapshot`, `__State.IsFrozen = true`, then `callJS("RF_setHitchanceLabels", getLabelsUIData(camera))`.
