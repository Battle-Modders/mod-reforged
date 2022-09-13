this.perk_rf_iron_sights <- ::inherit("scripts/skills/skill", {
	m = {
		Bonus = 25
	},
	function create()
	{
		this.m.ID = "perk.rf_iron_sights";
		this.m.Name = ::Const.Strings.PerkName.RF_IronSights;
		this.m.Description = ::Const.Strings.PerkDescription.RF_IronSights;
		this.m.Icon = "ui/perks/rf_iron_sights.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().isDisarmed()) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.RangedWeapon) &&
			 (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
			)
		{
			_properties.HitChance[::Const.BodyPart.Head] += this.m.Bonus;
		}
	}
});
