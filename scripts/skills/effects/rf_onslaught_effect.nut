this.rf_onslaught_effect <- ::inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		IsSpent = false,
		LineBreakerAdded = false
	},
	function create()
	{
		this.m.ID = "effects.rf_onslaught";
		this.m.Name = "Onslaught";
		this.m.Description = "This character is ready to push forward through the enemy's ranks.";
		this.m.Icon = "ui/perks/perk_rf_onslaught.png";
		this.m.IconMini = "rf_onslaught_effect_mini";
		this.m.Overlay = "rf_onslaught_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(10, {AddSign = true}) + " [Melee Skill|Concept.MeleeSkill]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(20, {AddSign = true}) + " [Initiative|Concept.Initiative]")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Gain one use of the [Linebreaker|Skill+rf_line_breaker_skill] skill that costs " + ::MSU.Text.colorPositive("1") + " fewer [Action Point|Concept.ActionPoints] and builds " + ::MSU.Text.colorPositive("10") + " less [Fatigue|Concept.Fatigue]")
			}
		]);
		
		return ret;
	}

	function onAdded()
	{
		if (!this.getContainer().hasSkill("actives.rf_line_breaker"))
		{
			this.m.LineBreakerAdded = true;
			this.getContainer().add(::Reforged.new("scripts/skills/actives/rf_line_breaker_skill", function(o) {
				o.m.IsForceEnabled = true;
			}));
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

	function onTurnStart()
	{
		if (--this.m.TurnsLeft == 0)
		{
			if (this.m.LineBreakerAdded) this.getContainer().removeByID("actives.rf_line_breaker");
			this.removeSelf();
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		if (this.m.LineBreakerAdded) this.getContainer().removeByID("actives.rf_line_breaker");
	}
});
