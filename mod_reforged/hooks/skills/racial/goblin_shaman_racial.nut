::Reforged.HooksMod.hook("scripts/skills/racial/goblin_shaman_racial", function(q) {
	q.create = @(__original) function()
	{
		__original();
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}
});
