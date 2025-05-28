::Reforged.HooksMod.hook("scripts/skills/traits/huge_trait", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+1") + " [Reach|Concept.Reach]")
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

	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		__original(_properties);
		_properties.Reach += 1;
	}}.onUpdate;
});
