::mods_hookExactClass("items/weapons/named/named_crossbow", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/heavy_crossbow";
		create();
	}

	// TODO: Needs to be done in some other way so that the changes to the skills
	// costs can be seen even before the update happens (useful for skill costs in weapon tooltip)
	o.onAfterUpdateProperties <- function( _properties )
	{
		this.named_weapon.onAfterUpdateProperties(_properties);

		local reload = this.getContainer().getActor().getSkills().findById("actives.reload_bolt");
		if (reload != null)
		{
			reload.m.ActionPointCost += 2;
			reload.m.FatigueCost += 5;
		}
	}
});
