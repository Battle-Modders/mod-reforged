::mods_hookExactClass("skills/actives/taunt", function(o) {
	local onVerifyTarget = o.onVerifyTarget;
	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		local ret = onVerifyTarget(_originTile, _targetTile);
		if (ret && _targetTile.getEntity().getSkills().hasSkill("effects.taunted"))	return false;
		return ret;
	}
});
