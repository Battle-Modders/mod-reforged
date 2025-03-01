this.rf_old_swordmaster_scenario_avatar_effect <- ::inherit("scripts/skills/effects/rf_old_swordmaster_scenario_abstract_effect", {
	m = {
		OldAgeStartDays = 30,
		NumRecruitsRequired = 5,
		DaysWithoutRecruits = 0,
		DaysWithoutRecruitsMax = 15,
		BrothersMax = 12,
		BrothersMaxInCombat = 10,
		MaxMalus = 30
	},
	function create()
	{
		this.rf_old_swordmaster_scenario_abstract_effect.create();
		this.m.ID = "effects.rf_old_swordmaster_scenario_avatar";
		this.m.Name = "Swordmaster\'s Finesse";
		this.m.Description = "This character is a renowned swordmaster - literally the stuff of legends. This effect becomes stronger with each level. However, as time passes by, old age may cause some attributes to suffer."
		this.m.Icon = "skills/rf_old_swordmaster_scenario_avatar_effect.png";
	}

	function getTooltip()
	{
		local ret = this.rf_old_swordmaster_scenario_abstract_effect.getTooltip();

		if (!this.isEnabled())
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Requires a Sword to be equipped")
			});
		}
		else
		{
			local skillBonus = this.getSkillBonus();

			ret.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(skillBonus, {AddSign = true}) + " [Melee Skill|Concept.MeleeSkill]")
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(skillBonus, {AddSign = true}) + " [Melee Defense|Concept.MeleeDefense]")
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(skillBonus, {AddSign = true}) + " [Resolve|Concept.Bravery]")
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/direct_damage.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(skillBonus, {AddSign = true, AddPercent = true}) + " damage ignores armor")
				}
			]);
		}

		local skillMalus = this.getSkillMalus();

		if (skillMalus > 0)
		{
			ret.extend([
				{
					id = 14,
					type = "text",
					icon = "ui/icons/health.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(-skillMalus, {AddSign = true}) + " [Hitpoints|Concept.Hitpoints]")
				},
				{
					id = 15,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(-skillMalus, {AddSign = true}) + " [Maximum Fatigue|Concept.Fatigue]")
				},
				{
					id = 16,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(::Math.floor(-skillMalus * 1.5), {AddSign = true}) + " [Initiative|Concept.Initiative]")
				},
				{
					id = 17,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = ::Reforged.Mod.Tooltips.parseString("Build " + ::MSU.Text.colorizeMultWithText(1.0 + 2 * skillMalus * 0.01, {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
				}
			]);
		}

		ret.push({
			id = 21,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Will get very angry if anyone in the company uses a melee weapon other than a Sword in combat"
		});

		if (this.m.DaysWithoutRecruits > 0)
		{
			ret.push({
				id = 22,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "The campaign will end if a total of " + ::MSU.Text.colorNegative(this.m.DaysWithoutRecruitsMax) + " days pass with fewer than " + ::MSU.Text.colorNegative(this.m.NumRecruitsRequired) + " recruits in your company. Currently " + ::MSU.Text.colorNegative(this.m.DaysWithoutRecruits) + " such days have passed"
			});
		}		

		return ret;
	}

	function getSkillBonus()
	{
		return this.getContainer().getActor().getLevel();
	}

	function getSkillMalus()
	{
		if (::World.Flags.get("RF_OldSwordmasterScenario_OldAgeEvent_1"))
		{
			return ::Math.min(this.m.MaxMalus, ::Math.max(1, (::World.getTime().Days - this.m.OldAgeStartDays) / 10));
		}
		
		return 0;
	}

	function onUpdate( _properties )
	{
		this.rf_old_swordmaster_scenario_abstract_effect.onUpdate(_properties);

		::World.Assets.m.BrothersMax = this.m.BrothersMax;
		::World.Assets.m.BrothersMaxInCombat = this.m.BrothersMaxInCombat;
			
		local actor = this.getContainer().getActor();
		if (this.isEnabled())
		{
			local skillBonus = this.getSkillBonus();
			_properties.MeleeSkill += skillBonus;
			_properties.MeleeDefense += skillBonus;
			_properties.Bravery += skillBonus;
			_properties.DamageDirectAdd += skillBonus * 0.01;			
		}

		local skillMalus = this.getSkillMalus();
		_properties.Stamina -= skillMalus;
		_properties.Initiative -= ::Math.floor(skillMalus * 1.5);
		_properties.Hitpoints -= skillMalus;
		_properties.FatigueEffectMult *= 1.0 + 2 * skillMalus * 0.01;
	}

	function onNewDay()
	{
		local bros = ::World.getPlayerRoster().getAll();

		if (bros.len() < this.m.NumRecruitsRequired)
		{
			this.m.DaysWithoutRecruits++;
			if (this.m.DaysWithoutRecruits > this.m.DaysWithoutRecruitsMax)
			{
				::World.Events.fire("event.rf_old_swordmaster_scenario_no_recruits_force_end");
				return;
			}
		}

		local hasMet = ::World.Flags.get("RF_OldSwordmasterScenario_OldAgeEvent_1");
		
		if (!hasMet && bros.len() >= 3 && ::World.getTime().Days >= this.m.OldAgeStartDays)
		{
			if (::World.Events.fire("event.rf_old_swordmaster_scenario_old_age_1"))
			{
				::World.Flags.set("RF_OldSwordmasterScenario_OldAgeEvent_1", true);
			}
		}

		hasMet = ::World.Flags.get("RF_OldSwordmasterScenario_OldAgeEvent_2");
		
		if (!hasMet && bros.len() >= 3 && ::World.getTime().Days >= this.m.OldAgeStartDays * 2)
		{
			if (::World.Events.fire("event.rf_old_swordmaster_scenario_old_age_2"))
			{
				::World.Flags.set("RF_OldSwordmasterScenario_OldAgeEvent_2", true);
			}
		}

		hasMet = ::World.Flags.get("RF_OldSwordmasterScenario_OldAgeEvent_3");
		
		if (!hasMet && bros.len() >= 3 && ::World.getTime().Days >= this.m.OldAgeStartDays * 3)
		{
			if (::World.Events.fire("event.rf_old_swordmaster_scenario_old_age_3"))
			{
				::World.Flags.set("RF_OldSwordmasterScenario_OldAgeEvent_3", true);
			}
		}

		hasMet = ::World.Flags.get("RF_OldSwordmasterScenario_OldAgeEvent_4");
		
		if (!hasMet && bros.len() >= 3 && ::World.getTime().Days >= this.m.OldAgeStartDays * 4)
		{
			if (::World.Events.fire("event.rf_old_swordmaster_scenario_old_age_4"))
			{
				::World.Flags.set("RF_OldSwordmasterScenario_OldAgeEvent_4", true);
			}
		}
	}

	function onSerialize( _out )
	{
		this.rf_old_swordmaster_scenario_abstract_effect.onSerialize(_out);
		_out.writeU16(this.m.DaysWithoutRecruits);
	}

	function onDeserialize( _in )
	{
		this.rf_old_swordmaster_scenario_abstract_effect.onDeserialize(_in);
		this.m.DaysWithoutRecruits = _in.readU16();
	}
});
