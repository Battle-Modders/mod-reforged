::Reforged.HooksMod.hook("scripts/skills/actives/taunt", function(q) {
	q.onVerifyTarget = @(__original) function( _originTile, _targetTile )
	{
		local ret = __original(_originTile, _targetTile);
		if (ret && _targetTile.getEntity().getSkills().hasSkill("effects.taunted"))	return false;
		return ret;
	}
});
