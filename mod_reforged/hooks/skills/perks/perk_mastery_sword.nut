::mods_hookExactClass("skills/perks/perk_mastery_sword", function(o) {
	local onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		onUpdate(_properties);
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Sword) && weapon.isItemType(::Const.Items.ItemType.RF_Southern))
		{
			_properties.ThresholdToInflictInjuryMult *= 0.75;
		}
	}
});
