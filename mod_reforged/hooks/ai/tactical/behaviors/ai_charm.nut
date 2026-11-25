::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_charm", function(q) {
	q.m.PossibleSkills.push("actives.rf_beckon_skill");
});
