::Reforged.HooksMod.hook("scripts/skills/traits/greedy_trait", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = ::MSU.Text.colorNegative("15%") + " more daily wage"
		});
		return ret;
	}}.getTooltip;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
				return 0.5;

			case "pg.rf_vicious":
				return 2;
		}
	}}.getPerkGroupMultiplier;
});
