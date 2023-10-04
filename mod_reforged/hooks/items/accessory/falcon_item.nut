::Reforged.HooksMod.hook("scripts/items/accessory/falcon_item", function(q) {
	q.m.InitiativeBonus <- 15;

	q.onUpdateProperties <- function( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		if (!this.isReleased())
		{
			_properties.Initiative += this.m.InitiativeBonus;
		}
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

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
