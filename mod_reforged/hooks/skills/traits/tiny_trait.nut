::Reforged.HooksMod.hook("scripts/skills/traits/tiny_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_tough": 0
		};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 12)
			{
				entry.text = ::MSU.Text.colorNegative("10%") + " reduced melee damage";
				break;
			}
		}

		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("-1") + " [Reach|Concept.Reach]")
		});
		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		local oldMult = _properties.MeleeDamageMult;
		__original(_properties);
		_properties.MeleeDamageMult = oldMult * 0.9; // Revert the vanilla mult and apply our own 0.9 mult
		_properties.Reach -= 1;
	}
});
