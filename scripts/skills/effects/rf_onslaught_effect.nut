this.rf_onslaught_effect <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		LineBreakerAdded = false
	},
	function create()
	{
		this.m.ID = "effects.rf_onslaught";
		this.m.Name = "Onslaught";
		this.m.Description = "This character is ready to push forward through the enemy's ranks.";
		this.m.Icon = "ui/perks/rf_onslaught.png";
		this.m.IconMini = "rf_onslaught_effect_mini";
		this.m.Overlay = "rf_onslaught_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::MSU.Text.colorizeValue(10) + " Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::MSU.Text.colorizeValue(20) + " Initiative"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gain one use of the \'Linebreaker\' skill with reduced Action Point and Fatigue Cost"
			}
		]);
		
		return tooltip;
	}

	function onAdded()
	{
		if (!this.getContainer().hasSkill("actives.rf_line_breaker"))
		{
			this.m.LineBreakerAdded = true;
			this.getContainer().add(::new("scripts/skills/actives/rf_line_breaker_skill"));
		}
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 10;
		_properties.Initiative += 20;
	}

	function onAfterUpdate( _properties )
	{
		if (!this.m.IsSpent)
		{
			local skill = this.getContainer().getSkillByID("actives.rf_line_breaker");
			if (skill != null)
			{
				skill.m.ActionPointCost -= 1;
				skill.m.FatigueCost -= 10;
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getID() == "actives.rf_line_breaker")
		{
			this.m.IsSpent = true;
		}
	}

	function onTurnEnd()
	{
		if (this.m.LineBreakerAdded) this.getContainer().removeByID("actives.rf_line_breaker");
		this.removeSelf();
	}
});

