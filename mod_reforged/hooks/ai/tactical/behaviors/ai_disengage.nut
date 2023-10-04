::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_disengage", function(q) {
	q.m.PossibleSkills.push("actives.rf_move_under_cover");
});
