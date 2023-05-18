::mods_hookExactClass("skills/actives/root_skill", function(o) {
	o.m.Cooldown <- 0;
	o.m.TurnsRemaining <- 0;

	local onUse = o.onUse;
	o.onUse = function( _user, _targetTile )
	{
		this.m.TurnsRemaining = this.m.Cooldown;
		return onUse(_user, _targetTile);
	}

	o.isUsable <- function()
	{
		return this.skill.isUsable() && this.m.TurnsRemaining == 0;
	}

	o.onTurnEnd <- function()
	{
		this.m.TurnsRemaining = ::Math.max(0, this.m.TurnsRemaining - 1);
	}
});
