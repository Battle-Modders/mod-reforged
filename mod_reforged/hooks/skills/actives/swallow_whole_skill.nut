::Reforged.HooksMod.hook("scripts/skills/actives/swallow_whole_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Swallow an adjacent player controlled character. Cannot be used while netted.";
	}

	q.isUsable = @(__original) function()
	{
		if (this.getContainer().hasSkill("effects.net"))
		{
			return false;
		}

		return __original();
	}
});
