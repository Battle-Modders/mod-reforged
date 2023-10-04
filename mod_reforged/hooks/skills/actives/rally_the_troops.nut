::Reforged.HooksMod.hook("scripts/skills/actives/rally_the_troops", function(q) {
	q.m.Cooldown <- 0;
	q.m.TurnsRemaining <- 0;

	q.create = @(__original) function()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Rally;
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{
		this.m.TurnsRemaining = this.m.Cooldown;
		return __original(_user, _targetTile);
	}

	q.isUsable = @(__original) function()
	{
		return __original() && this.m.TurnsRemaining == 0;
	}

	q.onTurnEnd <- function()
	{
		this.m.TurnsRemaining = ::Math.max(0, this.m.TurnsRemaining - 1);
	}
});
