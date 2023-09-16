::mods_hookExactClass("items/accessory/falcon_item", function(o) {
	o.m.InitiativeBonus <- 15;

	o.onUpdateProperties <- function( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		if (!this.isReleased())
		{
			_properties.Initiative += this.m.InitiativeBonus;
		}
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = getTooltip();

		if (!this.isReleased() && this.m.InitiativeBonus != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::MSU.Text.colorizeValue(this.m.InitiativeBonus) + " Initiative"
			});
		}

		return ret;
	}
});
