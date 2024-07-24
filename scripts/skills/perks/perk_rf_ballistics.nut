this.perk_rf_ballistics <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_ballistics";
		this.m.Name = ::Const.Strings.PerkName.RF_Ballistics;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Ballistics;
		this.m.Icon = "ui/perks/rf_ballistics.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _skill.isRanged())
		{
			_properties.HitChanceAdditionalWithEachTile += 2;
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.isAttack() && _skill.isRanged())
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "The penalty to hitchance per tile of distance is reduced by " + ::MSU.Text.colorPositive(2) + " due to " + this.getName()
			});
		}
	}
});
