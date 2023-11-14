::Reforged.HooksMod.hook("scripts/skills/traits/gluttonous_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.75,
			"pg.rf_fast": 0.75,
			"pg.rf_large": 2
		};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/asset_daily_food.png",
			text = "Requires " + ::MSU.Text.colorRed("+1") + " daily food"
		})
		return ret;
	}
});
