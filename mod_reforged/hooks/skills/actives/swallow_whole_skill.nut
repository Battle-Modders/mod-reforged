::Reforged.HooksMod.hook("scripts/skills/actives/swallow_whole_skill", function(q) {
	q.isUsable = @(__original) function()
	{
		if (this.getContainer().hasSkill("effects.net"))
		{
			return false;
		}

		return __original();
	}
});
