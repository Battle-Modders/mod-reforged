::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_defend_knock_back", function(q) {
	q.m.PossibleSkills.push("actives.rf_swordmaster_kick");
	q.m.PossibleSkills.push("actives.rf_net_pull");
});
