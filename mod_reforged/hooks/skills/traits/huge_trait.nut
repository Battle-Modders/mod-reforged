::mods_hookExactClass("skills/traits/huge_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 0.5,
			"pg.rf_large": -1
		};
	}
	
	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local tooltip = getTooltip();
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/reach.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+1[/color] Reach"
		});
		return tooltip;
	}

	o.onUpdate <- function( _properties )
	{
		_properties.Reach += 1;
	}
});
