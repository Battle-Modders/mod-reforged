::Reforged.HooksMod.hook("scripts/skills/actives/bandage_ally_skill", function(q) {
	q.onUse = @(__original) function( _user, _targetTile )
	{
		local ret = __original(_user, _targetTile);
		_targetTile.getEntity().setDirty();		// Vanilla Fix: Update the UI of the target so it will remove the bleeding/injury icons immediately
		return ret;
	}
});
