::Reforged.HooksMod.hook("scripts/skills/effects/smoke_effect", function(q) {
	q.m.RangedDefenseBonus <- 30;

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 12 && entry.icon == "ui/icons/ranged_defense.png")
			{
				// We replace a single line of the vanilla tooltip without touching the rest
				entry.text = ::MSU.Text.colorPositive("+" + this.m.RangedDefenseBonus) + " Ranged Defense";
				break;
			}
		}
		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local oldRangedDefenseMult = _properties.RangedDefenseMult;
		__original(_properties);
		_properties.RangedDefenseMult = oldRangedDefenseMult;	// We reset any change that vanilla or a mod may have made to the RangedDefenseMult

		if (this.isGarbage() == true) return;	 // Simple way of checking whether the line above skipped the buffs because the smoke effect is not active anymore
		_properties.RangedDefense += this.m.RangedDefenseBonus; // Now we apply the new reworked actual bonus of the smoke effect
	}
});
