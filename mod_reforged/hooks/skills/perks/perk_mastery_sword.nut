::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_sword", function(q) {
	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Sword) && weapon.isItemType(::Const.Items.ItemType.RF_Southern))
		{
			_properties.ThresholdToInflictInjuryMult *= 0.75;
		}
	}
});
