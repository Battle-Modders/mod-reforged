this.perk_rf_trauma_survivor <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_trauma_survivor";
		this.m.Name = ::Const.Strings.PerkName.RF_TraumaSurvivor;
		this.m.Description = ::Const.Strings.PerkDescription.RF_TraumaSurvivor;
		this.m.Icon = "ui/perks/rf_trauma_survivor.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		foreach (moraleCheckType in ::Const.MoraleCheckType)
		{
			_properties.NegativeMoraleCheckBraveryMult[moraleCheckType] *= 1.5;
		}

	}
});
	
