::Reforged.HooksMod.hook("scripts/ai/tactical/behavior", function(q) {
	q.queryTargetValue = @(__original) { function queryTargetValue( _entity, _target, _skill = null )
	{
		local score = __original(_entity, _target, _skill);
		if (_skill != null)
		{
			local rebuke = _target.getSkills().getSkillByID("effects.rf_rebuke");
			if (rebuke != null && rebuke.canProc(_entity, _skill))
				score *= this.getProperties().TargetPriorityCounterSkillsMult;
		}

		return ::Math.maxf(0.01, score);
	}}.queryTargetValue;
});
