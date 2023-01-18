::mods_hookExactClass("entity/tactical/actor", function(o) {
	o.m.IsPerformingAttackOfOpportunity <- false;

	o.isDisarmed <- function()
	{
		local handToHand = this.getSkills().getSkillByID("actives.hand_to_hand");
		return handToHand != null && handToHand.isUsable();
	}

	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.getSkills().add(::new("scripts/skills/effects/rf_encumbrance_effect"));
		this.getSkills().add(::new("scripts/skills/effects/rf_inspired_by_champion_effect"));
		this.getSkills().add(::new("scripts/skills/effects/rf_immersive_damage_effect"));
		this.getSkills().add(::new("scripts/skills/special/rf_reach"));
		this.getSkills().add(::new("scripts/skills/special/rf_formidable_approach_manager"));
		this.getSkills().add(::new("scripts/skills/special/rf_direct_damage_limiter"));
		this.getSkills().add(::new("scripts/skills/special/rf_polearm_adjacency"));

		local flags = this.getFlags();
		if (flags.has("undead") && !flags.has("ghost") && !flags.has("ghoul") && !flags.has("vampire"))
		{
			this.getSkills().add(::new("scripts/skills/effects/rf_undead_injury_receiver_effect"));
			if (flags.has("skeleton"))
			{
				this.m.ExcludedInjuries.extend(::Const.Injury.ExcludedInjuries.get(::Const.Injury.ExcludedInjuries.RF_Skeleton));
			}
			else
			{
				this.m.ExcludedInjuries.extend(::Const.Injury.ExcludedInjuries.get(::Const.Injury.ExcludedInjuries.RF_Undead));
			}
		}
	}

	local onAttackOfOpportunity = o.onAttackOfOpportunity;
	o.onAttackOfOpportunity = function( _entity, _isOnEnter )
	{
		this.m.IsPerformingAttackOfOpportunity = true;
		local ret = onAttackOfOpportunity(_entity, _isOnEnter);
		this.m.IsPerformingAttackOfOpportunity = false;
		return ret;
	}

	local checkMorale = o.checkMorale;
	o.checkMorale = function( _change, _difficulty, _type = ::Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		if (_change < 0)
		{
			this.getCurrentProperties().MoraleCheckBravery[_type] += this.getCurrentProperties().NegativeMoraleCheckBravery[_type];
			this.getCurrentProperties().MoraleCheckBraveryMult[_type] *= this.getCurrentProperties().NegativeMoraleCheckBraveryMult[_type];
		}
		else if (_change > 0)
		{
			this.getCurrentProperties().MoraleCheckBravery[_type] += this.getCurrentProperties().PositiveMoraleCheckBravery[_type];
			this.getCurrentProperties().MoraleCheckBraveryMult[_type] *= this.getCurrentProperties().PositiveMoraleCheckBraveryMult[_type];
		}

		checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);
	}

	local getSurroundedCount = o.getSurroundedCount;
	o.getSurroundedCount = function()
	{
		local startSurroundCountAt = this.m.CurrentProperties.StartSurroundCountAt;
		this.m.CurrentProperties.StartSurroundCountAt = ::Const.CharacterProperties.StartSurroundCountAt;

		local count = getSurroundedCount();

		foreach (enemy in ::Tactical.Entities.getHostileActors(this.getFaction(), this.getTile(), 2, true))
		{
			local perk = enemy.getSkills().getSkillByID("perk.rf_long_reach");
			if (perk != null && perk.isEnabled())
			{
				count++;
			}
		}

		this.m.CurrentProperties.StartSurroundCountAt = startSurroundCountAt;

		return ::Math.max(0, count - startSurroundCountAt);
	}
});
