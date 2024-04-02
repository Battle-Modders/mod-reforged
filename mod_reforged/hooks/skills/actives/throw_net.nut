::Reforged.HooksMod.hook("scripts/skills/actives/throw_net", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.ThrowNet;
	}

	q.onVerifyTarget = @(__original) function( _originTile, _targetTile )
	{
		return __original(_originTile, _targetTile) && !_targetTile.getEntity().getCurrentProperties().IsImmuneToRoot;
	}
});
