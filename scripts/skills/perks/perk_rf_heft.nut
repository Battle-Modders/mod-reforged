this.perk_rf_heft <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_heft";
		this.m.Name = ::Const.Strings.PerkName.RF_Heft;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Heft;
		this.m.Icon = "ui/perks/perk_rf_heft.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onUpdate(_properties)
	{
		if (this.getContainer().getActor().isDisarmed()) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Axe))
		{
			_properties.DamageRegularMax += ::Math.floor(weapon.m.RegularDamageMax * 0.3);
		}
	}
});
