::Reforged.HooksMod.hook("scripts/skills/traits/spartan_trait", function(q) {
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

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_tough":
			case "pg.rf_vigorous":
				return 0.5;
		}
	}
});
