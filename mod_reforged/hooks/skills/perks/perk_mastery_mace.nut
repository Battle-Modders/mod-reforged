::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_mace", function(q) {
	q.m.PoiseDamageMult <- 1.5;

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		_properties.IsSpecializedInMaces = false;	//

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Mace)) return false;

		_properties.PoiseDamageMult *= this.m.PoiseDamageMult;	// Currently this improves global poise damage while wielding a mace and is not limited to only mace skills
	}
});
