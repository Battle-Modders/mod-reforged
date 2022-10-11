this.rf_reach_effect <- ::inherit("scripts/skills/skill", {
	m = {
		BonusPerReach = 5
		CurrChange = 0
	},
	function create()
	{
		this.m.ID = "effects.rf_reach";
		this.m.Name = "Reach";
		this.m.Description = "Reach is a depiction of how far this character\'s attacks can reach, making melee combat easier against targets with shorter reach. Greater Reach grants a Melee Skill bonus of " + ::MSU.Text.colorizeValue(this.m.BonusPerReach) + " whereas shorter reach incurs a Melee Skill penalty of " + ::MSU.Text.colorizeValue(-1 * this.m.BonusPerReach) + " per difference in reach between the attacker and the defender. A character without Zone of Control has no Reach.";
		this.m.Icon = "skills/rf_reach_effect.png";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast + 100;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getName()
	{
		return this.getContainer().getActor().isPlayerControlled() ? this.m.Name : this.m.Name + " (" + this.getContainer().getActor().getReach() + ")";
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/reach.png",
			text = "Current Reach: " + this.getContainer().getActor().getReach()
		});
		return tooltip;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.m.CurrChange = 0;
		if (_targetEntity != null && !_skill.isRanged())
		{
			local difference = this.getContainer().getActor().getReach() - _targetEntity.getReach();
			if ((difference > 0 && _targetEntity.isArmedWithShield()) || (difference < 0 && this.getContainer().getActor().isArmedWithShield())) return;

			this.m.CurrChange = this.m.BonusPerReach * difference;
			_properties.MeleeSkill += this.m.CurrChange;
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (!_targetTile.IsOccupiedByActor || _skill.isRanged() || this.m.CurrChange == 0) return;

		_tooltip.push({
			icon = this.m.CurrChange > 0 ? "ui/tooltips/positive.png" : "ui/tooltips/negative.png",
			text = ::MSU.Text.colorizePercentage(this.m.CurrChange) + " " + this.getName()
		});
	}
});
