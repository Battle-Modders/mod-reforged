::Reforged.HooksMod.hook("scripts/skills/traits/gluttonous_trait", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/asset_daily_food.png",
			text = "Consumes " + ::MSU.Text.colorNegative("+1") + " food daily"
		})

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/asset_daily_food.png",
			text = "Lose " + ::MSU.Text.colorNegative("100%") + " more mood due to going hungry"
		});

		return ret;
	}}.getTooltip;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_agile":
			case "pg.rf_fast":
				return 0.5;

			case "pg.rf_tough":
			case "pg.rf_vigorous":
				return 2;
		}
	}}.getPerkGroupMultiplier;
});
