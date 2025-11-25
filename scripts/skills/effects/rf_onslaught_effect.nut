this.rf_onslaught_effect <- ::inherit("scripts/skills/skill", {
	m = {
		RoundsLeft = 2
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
				text = ::Reforged.Mod.Tooltips.parseString("Gain one use of the [$ $|Skill+rf_line_breaker_onslaught_skill] skill")
			},
			{
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will expire in " + this.m.RoundsLeft + " [round(s)|Concept.Round]")
			}
		]);
		
		return ret;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_line_breaker_onslaught_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_line_breaker_onslaught");
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 10;
		_properties.Initiative += 20;
	}

	function onRoundEnd()
	{
		if (--this.m.RoundsLeft == 0)
		{
			this.removeSelf();
		}
	}
});
