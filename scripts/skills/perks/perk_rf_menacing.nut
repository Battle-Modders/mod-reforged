this.perk_rf_menacing <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_menacing";
		this.m.Name = ::Const.Strings.PerkName.RF_Menacing;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Menacing;
		this.m.Icon = "ui/perks/rf_menacing.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onUpdate( _properties )
	{
		_properties.Threat += 10;
	}
});
