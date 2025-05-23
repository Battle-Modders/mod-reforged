::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_terror", function(q) {
	q.m.PossibleSkills.push("actives.rf_wail");
});
