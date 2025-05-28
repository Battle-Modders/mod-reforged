::Reforged.HooksMod.hook("scripts/skills/traits/tiny_trait", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 12)
			{
				entry.text = ::MSU.Text.colorNegative("10%") + " less melee damage";
				break;
			}
		}

		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("-1") + " [Reach|Concept.Reach]")
		});
		return ret;
	}}.getTooltip;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_tough":
				return 0;
		}
	}}.getPerkGroupMultiplier;

	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		local oldMult = _properties.MeleeDamageMult;
		__original(_properties);
		_properties.MeleeDamageMult = oldMult * 0.9; // Revert the vanilla mult and apply our own 0.9 mult
		_properties.Reach -= 1;
	}}.onUpdate;
});
