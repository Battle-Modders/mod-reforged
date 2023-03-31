::mods_hookExactClass("skills/actives/root_skill", function(o) {
	o.m.Cooldown <- 0;
	o.onTurnStart <- function()
	{
		this.m.Cooldown = ::Math.max(0, this.m.Cooldown - 1);
	}

	local isUsable = o.isUsable;
	o.isUsable = function()
	{
		return isUsable() && (this.getContainer().getActor().isPlayerControlled() || this.m.Cooldown == 0);
	}

	local onUse = o.onUse;
	o.onUse = function( _user, _targetTile )
	{
		local ret = onUse(_user, _targetTile);
		this.m.Cooldown = 3;
		return ret;
	}
});
