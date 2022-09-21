this.perk_rf_clarity <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_clarity";
		this.m.Name = ::Const.Strings.PerkName.RF_Clarity;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Clarity;
		this.m.Icon = "ui/perks/rf_clarity.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			skill.m.FatigueCostMult *= 0.8;
		}
	}
});
