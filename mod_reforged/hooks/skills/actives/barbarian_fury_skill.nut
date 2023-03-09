::mods_hookExactClass("skills/actives/barbarian_fury_skill", function(o) {
	local onVerifyTarget = o.onVerifyTarget;
	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		local ret = onVerifyTarget(_originTile, _targetTile);
		local user = this.getContainer().getActor();

		// Only allow AI to use the skill if at least one of the two characters has an adjacent enemy
		if (ret && !user.isPlayerControlled())
		{
			ret = false;
			for (local i = 0; i < 6; i++)
			{
				if (_originTile.hasNextTile(i))
				{
					local nextTile = _originTile.getNextTile(i);
					if (nextTile.IsOccupiedByActor && !nextTile.getEntity().isAlliedWith(user))
					{
						ret = true;
						break;
					}
				}
				if (_targetTile.hasNextTile(i))
				{
					local nextTile = _targetTile.getNextTile(i);
					if (nextTile.IsOccupiedByActor && !nextTile.getEntity().isAlliedWith(user))
					{
						ret = true;
						break;
					}
				}
			}
		}

		return ret;
	}
});
