::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_bow", function(q) {
	q.m.PossibleSkills.push("actives.rf_flaming_arrows");
});
