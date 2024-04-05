::Reforged.HooksMod.hook("scripts/skills/traits/brute_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": 0,
			"pg.rf_axe": 1.5,
			"pg.rf_flail": 2,
			"pg.rf_mace": 1.5,
			"pg.rf_spear": 0,
			"pg.rf_sword": 0.9,
			"pg.special.rf_back_to_basics": 0
		};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		foreach(entry in ret)
		{
			if (entry.id == 10 && entry.icon == "ui/icons/chance_to_hit_head.png")
			{
				entry.text = "Melee Damage is increased by " + ::MSU.Text.colorGreen("+15%") + " on a hit to the head";
				break;
			}
		}
		return ret;
	}
});
