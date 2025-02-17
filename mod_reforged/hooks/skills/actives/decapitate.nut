::Reforged.HooksMod.hook("scripts/skills/actives/decapitate", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Decapitate;
	}

	// VanillaFix: vanilla manually calculates the damage range for this tooltip using CurrentProperties
	// whereas it should be using buildPropertiesForUse because otherwise it misses the damage buffs
	// which are applied during onAnySkillUsed from perks etc.
	q.getTooltip = @() function()
	{
		// getDefaultTooltip uses buildPropertiesForUse and is the standard function for creating tooltips of attack skills
		local ret = this.skill.getDefaultTooltip();
		foreach (entry in ret)
		{
			// Replace the hitpoints damage text so it follows vanilla decapitate tooltip wording
			if (entry.id == 4)
			{
				entry.text = ::String.replace(entry.text, "to hitpoints, of which", "depending on how wounded the target already is, of which");
				break;
			}
		}
		return ret;
	}

	// We adjust the _targetEntity == null case so that the tooltip of the skill shows the correct
	// damage values after the vanilla fix above.
	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			// This is so that the tooltip shows the intended values when viewing the tooltip of the skill
			if (_targetEntity == null)
			{
				// So that the max HP damage appears x2 just like in vanilla
				_properties.DamageTooltipMaxMult *= 2.0;
				// The above property will make the armor damage appear x2 as well, so we halve it manually
				_properties.DamageArmorMult *= 0.5;
			}
			// Else clause is vanilla behavior
			else
			{
				_properties.DamageRegularMult += 1.0 - _targetEntity.getHitpoints() / (_targetEntity.getHitpointsMax() * 1.0);
			}
		}
	}
});
