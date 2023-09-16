::mods_hookExactClass("items/accessory/falcon_item", function(o) {
	o.m.InitiativeBonus <- 15;

	local onUpdateProperties <- function( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		if (!this.isUnleashed())
		{
			_properties.Initiative += this.m.InitiativeBonus;
		}
	}
});
