this.rf_old_swordmaster_scenario_exhausted_effect <- ::inherit("scripts/skills/skill", {
	m = {
		StartTime = 0 // Total in-game seconds based on ::World.getTime(),
	},
	function create()
	{
		this.m.ID = "effects.rf_old_swordmaster_scenario_exhausted";
		this.m.Name = "Exhausted";
		this.m.Description = "This character is exhausted after having participated in a battle.";
		this.m.Icon = "skills/rf_old_swordmaster_scenario_exhausted_effect.png";
		this.m.Type = ::Const.SkillType.StatusEffect;
	}

	function isHidden()
	{
		return this.getExhaustionMult() == 1.0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local exhaustionMult = this.getExhaustionMult();

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(exhaustionMult) + " [Melee Skill|Concept.MeleeSkill]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(exhaustionMult) + " [Melee Defense|Concept.MeleeDefense]")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(exhaustionMult) + " [Ranged Skill|Concept.RangeSkill]")
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(exhaustionMult) + " [Ranged Defense|Concept.RangeDefense]")
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(exhaustionMult) + " [Maximum Fatigue|Concept.Fatigue]")
			}
		]);

		local daysRemaining = this.getDaysRemaining();
		ret.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("These effects only apply during battle. Will expire %s", daysRemaining == 0 ? "soon" : "in " + daysRemaining + " days"))
		});

		return ret;
	}

	function onAdded()
	{
		if (this.m.IsNew)
		{
			this.m.StartTime = 0;
		}
	}

	function onUpdate( _properties )
	{
		if (::Tactical.isActive())
		{
			local mult = this.getExhaustionMult();
			if (mult != 1.0)
			{
				_properties.MeleeSkillMult *= mult;
				_properties.RangedSkillMult *= mult;
				_properties.MeleeDefenseMult *= mult;
				_properties.RangedDefenseMult *= mult;
				_properties.StaminaMult *= mult;
			}
		}
	}

	function getDaysToExhaust()
	{
		return ::Math.min(3, 1 + ::World.getTime().Days / 30);
	}

	// In-game campaign duration in seconds when exhaustion started
	function getStartTime()
	{
		return this.m.StartTime;
	}

	// In-game campaign duration in seconds when exhaustion will end
	function getEndTime()
	{
		return this.m.StartTime + this.getDaysToExhaust() * ::World.getTime().SecondsPerDay;
	}

	// Current in-game campaign duration in seconds
	function getCurrTime()
	{
		return (::World.getTime().Days - 1) * ::World.getTime().SecondsPerDay + ::World.getTime().SecondsOfDay;
	}

	function getExhaustionMult()
	{
		if (this.m.StartTime == 0)
			return 1.0;

		return ::Math.maxf(0.0, ::Math.minf(1.0, (this.getCurrTime() - this.m.StartTime) / (this.getEndTime() - this.m.StartTime)));
	}

	function getDaysRemaining()
	{
		return ::Math.floor((this.getEndTime() - this.getCurrTime()) / ::World.getTime().SecondsPerDay);
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.StartTime = this.getCurrTime();
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU32(this.m.StartTime);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.StartTime = _in.readU32();
	}
});
