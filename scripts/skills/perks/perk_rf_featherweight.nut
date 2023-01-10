this.perk_rf_featherweight <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_featherweight";
		this.m.Name = ::Const.Strings.PerkName.RF_Featherweight;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Featherweight;
		this.m.Icon = "ui/perks/rf_featherweight.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || weapon.getStaminaModifier() >= -3)
		{
			_properties.ActionPoints += 1;
		}
	}
});

