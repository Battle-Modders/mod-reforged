::Reforged.HooksMod.hook("scripts/ai/tactical/behavior", function(q) {
	q.queryTargetValue = @(__original) function( _entity, _target, _skill = null )
	{
		// Currently Mortars are near invincible and not meant to be killed. But AI still targets them sometimes. This line should make it so they are basically never targeted.
		if (_target.getType() == ::Const.EntityType.Mortar) return 0.01;

		local score = __original(_entity, _target, _skill);
		if (_skill != null)
		{
			local rebuke = _target.getSkills().getSkillByID("effects.rf_rebuke");
			if (rebuke != null && rebuke.canProc(_entity, _skill))
				score *= this.getProperties().TargetPriorityCounterSkillsMult;
		}

		return ::Math.maxf(0.01, score);
	}
});
