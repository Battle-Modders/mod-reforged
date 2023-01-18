::mods_hookExactClass("skills/actives/rally_the_troops", function(o) {
	o.m.Cooldown <- 0;
	o.m.TurnsRemaining <- 0;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Rally;
	}

	local onUse = o.onUse;
	o.onUse = function( _user, _targetTile )
	{
		this.m.TurnsRemaining = this.m.Cooldown;
		return onUse(_user, _targetTile);
	}

	local isUsable = o.isUsable;
	o.isUsable = function()
	{
		return isUsable() && this.m.TurnsRemaining == 0;
	}

	o.onTurnEnd <- function()
	{
		this.m.TurnsRemaining = ::Math.max(0, this.m.TurnsRemaining - 1);
	}
});
