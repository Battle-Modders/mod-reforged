::Reforged.HooksMod.hook("scripts/skills/actives/adrenaline_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.FatigueCost = 10;	// In vanilla this is 20
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Adrenaline;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Not affected by, and cannot receive, [temporary injuries|Concept.InjuryTemporary] while active")
		});

		return ret;
	}
});
