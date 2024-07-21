this.perk_rf_finesse <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_finesse";
		this.m.Name = ::Const.Strings.PerkName.RF_Finesse;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Finesse;
		this.m.Icon = "ui/perks/perk_rf_finesse.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Any;
	}

	function onAfterUpdate( _properties )
	{
		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			skill.m.FatigueCostMult *= 0.8;
		}
	}
});
