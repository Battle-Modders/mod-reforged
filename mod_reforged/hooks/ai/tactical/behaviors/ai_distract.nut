::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_distract", function(q) {
	q.m.PossibleSkills.push("actives.rf_pocket_sand_skill");
	q.m.PossibleSkills.push("actives.rf_shield_bash");
});
