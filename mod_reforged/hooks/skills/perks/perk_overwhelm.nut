::mods_hookExactClass("skills/perks/perk_overwhelm", function (o) {
	local onTargetHit = o.onTargetHit;
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isRanged())
		{
			onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
		}
	}

	local onTargetMissed = o.onTargetMissed;
	o.onTargetMissed = function( _skill, _targetEntity )
	{
		if (!_skill.isRanged())
		{
			onTargetMissed(_skill, _targetEntity);
		}
	}
});
