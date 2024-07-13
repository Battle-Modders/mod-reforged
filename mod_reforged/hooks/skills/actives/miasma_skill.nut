::Reforged.HooksMod.hook("scripts/skills/actives/miasma_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Miasma Cloud";
		this.m.Description = "Spreads a poisonous miasma across a targeted area. Any living being ending their turn within this hazardous area will take damage - friend and foe alike.";
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cover an area of " + ::MSU.Text.colorPositive("7") + " tiles in miasma for " + ::MSU.Text.colorPositive("3") + " rounds."
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Replace any existing tile effect"
		});

		return ret;
	}
});
