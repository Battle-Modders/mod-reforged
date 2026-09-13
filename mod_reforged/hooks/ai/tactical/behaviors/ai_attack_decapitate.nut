::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_decapitate", function(q) {
	local idx = q.m.PossibleSkills.find("actives.exesword_decapitate");
	if (idx != null) q.m.PossibleSkills.remove(idx);
});
