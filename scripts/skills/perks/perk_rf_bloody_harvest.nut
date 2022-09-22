this.perk_rf_bloody_harvest <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_bloody_harvest";
		this.m.Name = ::Const.Strings.PerkName.RF_BloodyHarvest;
		this.m.Description = ::Const.Strings.PerkDescription.RF_BloodyHarvest;
		this.m.Icon = "ui/perks/rf_bloody_harvest.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _skill.isAOE() && !_skill.isRanged())
		{
			_properties.DamageTotalMult *= 1.1;
			_properties.MeleeSkill += 10;
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.isAttack() && _skill.isAOE() && !_skill.isRanged())
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorizePercentage(10) + " chance to hit due to " + this.getName()
			});
		}
	}
});
