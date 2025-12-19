this.rf_barrow_chant_debuff_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_barrow_chant_debuff";
		this.m.Name = "Affected by Barrow Chant";
		// TODO: Placeholder icons
		this.m.Icon = "ui/perks/perk_32.png";
		// this.m.IconMini = "TODO";
		// this.m.Overlay = "TODO";
		this.m.Description = "This character\'s ears are ringing with a chant full of dread.";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function isHidden()
	{
		return this.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Ignore;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Cannot be [Confident|Concept.Morale]")
		});
		return ret;
	}

	function onAdded()
	{
		// `mood_check` can set players at Confident during onCombatStart.
		// This happens before this skill can push Confident as a forbidden morale state (as this skill
		// is added via onActorSpawned).
		// So we manually remove Confident after this effect has been added to the actor.
		local actor = this.getContainer().getActor();
		if (actor.getMoraleState() == ::Const.MoraleState.Confident)
		{
			// Set the actor to the first non-forbidden morale state below Confident.
			local newState = ::Const.MoraleState.Confident - 1;
			while (actor.getCurrentProperties().MV_ForbiddenMoraleStates.find(newState) != null)
			{
				// We don't want to make the character Flee, so the
				// maximum we go down is to 1 state above Fleeing.
				if (--newState == ::Const.MoraleState.Fleeing + 1)
				{
					break;
				}
			}

			actor.setMoraleState(newState);
		}
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().getMoraleState() != ::Const.MoraleState.Ignore)
		{
			_properties.MV_ForbiddenMoraleStates.push(::Const.MoraleState.Confident);
		}
	}
});
