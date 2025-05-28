::Reforged.HooksMod.hook("scripts/skills/traits/brute_trait", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		foreach(entry in ret)
		{
			if (entry.id == 10 && entry.icon == "ui/icons/chance_to_hit_head.png")
			{
				entry.text = "Deal " + ::MSU.Text.colorPositive("15%") + " more Melee Damage on a hit to the head";
				break;
			}
		}
		return ret;
	}}.getTooltip;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_trained":
			case "pg.rf_spear":
			case "pg.special.rf_back_to_basics":
				return 0;

			case "pg.rf_axe":
			case "pg.rf_mace":
				return 1.5;

			case "pg.rf_flail":
				return 2;

			case "pg.rf_sword":
				return 0.9;
		}
	}}.getPerkGroupMultiplier;
});
