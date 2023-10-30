::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_split", function(q) {
	q.m.PossibleSkills.push("actives.rf_cleaving_split");
});
