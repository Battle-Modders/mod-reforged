::Reforged.HooksMod.hook("scripts/skills/traits/huge_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 0.5,
			"pg.rf_large": -1
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
