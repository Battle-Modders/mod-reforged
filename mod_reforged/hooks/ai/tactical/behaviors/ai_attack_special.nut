::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_attack_special", function(q) {
	local idx = q.m.PossibleSkills.find("actives.perforate");
	if (idx != null) 
	{
		q.m.PossibleSkills.remove(idx);
	}
	idx = q.m.PossibleSkills.find("actives.skewer");
	if (idx != null) 
	{
		q.m.PossibleSkills.remove(idx);
	}
});
