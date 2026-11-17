# Reforged - notes

Shared notes and skills: the `bb-agents` repo next to this one (`<workspace>\bb-agents`).

## Layout
- `scripts/`: new classes (skills, perks, effects, entities, AI behaviors `scripts/ai/tactical/behaviors/ai_rf_*.nut`).
- `mod_reforged/hooks/`: hooks onto vanilla scripts, mirroring vanilla paths.
- `mod_reforged/hooks/config/ai.nut` registers custom behaviors (`::MSU.AI.addBehavior`); `mod_reforged/config/ai.nut` has `::Reforged.AI.ExcludedBehaviors` per agent.
- `mod_reforged/hooks/config/strings.nut`: perk names and descriptions. `mod_reforged/msu_systems/`: mod settings, keybinds, tooltips.

## Compatibility
- `mod_reforged/mod_conflicts.nut` lists the mods Reforged is incompatible with (e.g. `mod_legends`). Never check Reforged features against them or adapt Reforged to them.
- mod_hardened follows breaking changes in Reforged. Don't keep Reforged's API (function names, tooltip entry ids, setting IDs) stable for it.
- Saved MSU setting values don't need to survive a rename: choose the setting IDs that fit best.

## AI behaviors
Vanilla AI facts: shared `bb-tactical-ai` skill.
- Naming: file `ai_rf_<name>.nut`, class `ai_rf_<name>`, id `RF_<Name>`; the skill sets `m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_<Name>`. Behaviors extending a vanilla one inherit it (e.g. `ai_rf_attack_lunge` from `ai_attack_default`), others inherit `scripts/ai/tactical/behavior`.

## Hit-chance overlay
Design decisions and pitfalls: the `reforged-hitchance-overlay` skill, `.claude/skills/reforged-hitchance-overlay/SKILL.md` in this repo (read it directly if your agent doesn't load skills from `.claude/skills`).
- `mod_reforged/hitchance_overlay.nut` (`::Reforged.HitchanceOverlay`), `ui/mods/mod_reforged/rf_hitchance_overlay.js` and `css_hooks/screens/tactical/rf_hitchance_overlay.css`; the movement-preview tile tooltip (`tooltip_events.RF_getMovementPreviewTooltip`) shares its `compute()`.
- Test: `tests/hitchance_overlay.nut`. Benchmark: `--filter bench` (`tests/hitchance_overlay_bench.nut`); its `FINGERPRINT` rows must stay unchanged when tuning.
