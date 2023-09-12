::mods_hookExactClass("items/accessory/warhound_item", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.StaminaModifier = -3;
	}

	o.getStaminaModifier <- function()
	{
		return this.isUnleashed() ? 0 : this.accessory.getStaminaModifier();
	}
});
