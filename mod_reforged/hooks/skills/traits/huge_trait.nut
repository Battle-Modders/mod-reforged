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
		local tooltip = __original();
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/reach.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+1[/color] Reach"
		});
		return tooltip;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		_properties.Reach += 1;
	}
});
