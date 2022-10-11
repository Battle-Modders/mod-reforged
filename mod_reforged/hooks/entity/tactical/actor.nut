::mods_hookExactClass("entity/tactical/actor", function(o) {
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
		this.getSkills().add(::new("scripts/skills/effects/rf_polearm_hitchance_effect"));
		this.getSkills().add(::new("scripts/skills/effects/rf_inspired_by_champion_effect"));
		this.getSkills().add(::new("scripts/skills/effects/rf_immersive_damage_effect"));

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
});
