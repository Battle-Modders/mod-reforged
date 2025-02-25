::Reforged.HooksMod.hook("scripts/skills/traits/disloyal_trait", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = ::MSU.Text.colorNegative("100%") + " more chance to desert on low mood"
		});
		return ret;
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
				return 0;
		}
	}
});
