::Reforged.HooksMod.hook("scripts/skills/actives/rally_the_troops", function(q) {
	q.m.Cooldown <- 0;
	q.m.TurnsRemaining <- 0;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Rally;
	}}.create;

	q.onUse = @(__original) { function onUse( _user, _targetTile )
	{
		this.m.TurnsRemaining = this.m.Cooldown;
		return __original(_user, _targetTile);
	}}.onUse;

	q.isUsable = @(__original) { function isUsable()
	{
		return __original() && this.m.TurnsRemaining == 0;
	}}.isUsable;

	q.onTurnEnd = @() { function onTurnEnd()
	{
		this.m.TurnsRemaining = ::Math.max(0, this.m.TurnsRemaining - 1);
	}}.onTurnEnd;
});
