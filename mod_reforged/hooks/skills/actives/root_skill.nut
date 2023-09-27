::Reforged.HooksMod.hook("scripts/skills/actives/root_skill", function(q) {
	q.m.Cooldown <- 0;
	q.m.TurnsRemaining <- 0;

	q.onUse = @(__original) function( _user, _targetTile )
	{
		this.m.TurnsRemaining = this.m.Cooldown;
		return __original(_user, _targetTile);
	}

	q.isUsable <- function()
	{
		return this.skill.isUsable() && this.m.TurnsRemaining == 0;
	}

	q.onTurnEnd <- function()
	{
		this.m.TurnsRemaining = ::Math.max(0, this.m.TurnsRemaining - 1);
	}
});
