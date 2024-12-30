::Reforged.HooksMod.hook("scripts/skills/actives/lightning_storm_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Marks a vertical line of tiles for impact, with lightning striking the marked tiles one turn later, dealing significant damage to enemies along the path.";
		this.m.InjuriesOnBody = null;	// These are not used by vanilla and only produce a confusing tooltip line via msu
		this.m.InjuriesOnHead = null;	// These are not used by vanilla and only produce a confusing tooltip line via msu
	}

	q.getTooltip = @() function()
	{
		return this.skill.getDefaultUtilityTooltip();
	}
});
