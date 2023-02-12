this.perk_rf_savage_strength <- ::inherit("scripts/skills/skill", {
	m = {
		Mult = 0.75
	},
	function create()
	{
		this.m.ID = "perk.rf_savage_strength";
		this.m.Name = ::Const.Strings.PerkName.RF_SavageStrength;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SavageStrength;
		this.m.Icon = "ui/perks/rf_savage_strength.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			if (skill.isAttack() && skill.m.IsWeaponSkill)
			{
				skill.m.FatigueCostMult *= this.m.Mult;
			}
		}
	}
});
