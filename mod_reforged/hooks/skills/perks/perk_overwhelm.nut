::Reforged.HooksMod.hook("scripts/skills/perks/perk_overwhelm", function(q) {
	q.onTargetHit = @(__original) function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isRanged())
		{
			__original(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
		}
	}

	q.onTargetMissed = @(__original) function( _skill, _targetEntity )
	{
		if (!_skill.isRanged())
		{
			__original(_skill, _targetEntity);
		}
	}
});
