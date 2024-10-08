::Reforged.HooksMod.hook("scripts/skills/traits/huge_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_fast": 0.5,
			"pg.rf_tough": 2,
			"pg.rf_vigorous": 2
		};
	}
	
	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+1") + " [Reach|Concept.Reach]")
		});
		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		_properties.Reach += 1;
	}
});
