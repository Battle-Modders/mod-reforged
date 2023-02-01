this.perk_rf_personal_armor <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_personal_armor";
		this.m.Name = ::Const.Strings.PerkName.RF_PersonalArmor;
		this.m.Description = ::Const.Strings.PerkDescription.RF_PersonalArmor;
		this.m.Icon = "ui/perks/rf_personal_armor.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedArmorMult *= 0.9;
	}
});
