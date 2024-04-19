::Reforged.HooksMod.hook("scripts/skills/traits/spartan_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_resilient": 0.5
		};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/asset_daily_food.png",
			text = "Consumes " + ::MSU.Text.colorGreen("-1") + " food daily"
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/asset_daily_food.png",
			text = "Lose " + ::MSU.Text.colorGreen("50%") + " less mood when going hungry"
		});

		return ret;
	}
});
