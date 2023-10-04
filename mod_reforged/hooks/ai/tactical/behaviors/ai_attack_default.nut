::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_default", function(q) {
	q.m.PossibleSkills.push("actives.rf_sword_thrust");
	q.m.PossibleSkills.push("actives.rf_between_the_eyes");
	q.m.PossibleSkills.push("actives.rf_flail_pole");
});
