::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_knock_out", function(q) {
	q.m.PossibleSkills.push("actives.rf_hook_shield");
});
