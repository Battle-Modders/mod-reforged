::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_line_breaker", function(q) {
	q.m.PossibleSkills.push("actives.rf_swordmaster_push_through");
	q.m.PossibleSkills.push("actives.rf_swordmaster_tackle");
	q.m.PossibleSkills.push("actives.rf_line_breaker");
	q.m.PossibleSkills.push("actives.rf_pummel");
});
