::Reforged.HooksMod.hook("scripts/skills/traits/spartan_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_tough": 0.5,
			"pg.rf_vigorous": 0.5
		};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/asset_daily_food.png",
			text = "Consumes " + ::MSU.Text.colorPositive("-1") + " food daily"
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/asset_daily_food.png",
			text = "Lose " + ::MSU.Text.colorPositive("50%") + " less mood due to going hungry"
		});

		return ret;
	}
});
