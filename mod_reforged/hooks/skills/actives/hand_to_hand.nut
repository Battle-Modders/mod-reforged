::Reforged.HooksMod.hook("scripts/skills/actives/hand_to_hand", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (i, entry in ret)
		{
			if (entry.id == 6)
			{
				ret.remove(i); // Remove any mention about the hitchance debuff
				break;
			}
		}

		return ret;
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		local old_MeleeSkill = _properties.MeleeSkill;

		__original(_skill, _targetEntity, _properties);

		if (_skill == this)
		{
			_properties.MeleeSkill = old_MeleeSkill; // This reverts the vanilla -10 Modifier
		}
	}
});
