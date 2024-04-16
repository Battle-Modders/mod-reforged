::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_gash", function(q) {
	q.m.PossibleSkills.push("actives.rf_gouge");
});
