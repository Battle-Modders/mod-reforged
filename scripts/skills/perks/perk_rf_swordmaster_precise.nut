this.perk_rf_swordmaster_precise <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_precise";
		this.m.Name = this.Const.Strings.PerkName.RF_SwordmasterPrecise;
		this.m.Description = this.Const.Strings.PerkDescription.RF_SwordmasterPrecise;
		this.m.Icon = "ui/perks/rf_swordmaster_precise.png";
	}

	function onUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.RF_Fencing))
		{
			_properties.DirectDamageAdd += 1.25;
		}
	}
});
