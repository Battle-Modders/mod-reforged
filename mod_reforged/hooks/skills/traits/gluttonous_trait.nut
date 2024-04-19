::Reforged.HooksMod.hook("scripts/skills/traits/gluttonous_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_fast": 0.5,
			"pg.rf_tough": 2,
			"pg.rf_vigorous": 2
		};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/asset_daily_food.png",
			text = "Consumes " + ::MSU.Text.colorNegative("+1") + " food daily"
		})

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/asset_daily_food.png",
			text = "Lose " + ::MSU.Text.colorNegative("100%") + " more mood when going hungry"
		});

		return ret;
	}
});
