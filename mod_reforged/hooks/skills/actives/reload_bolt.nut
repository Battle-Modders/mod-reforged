::mods_hookExactClass("skills/actives/reload_bolt", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsRemovedAfterBattle = false;
	}
	// Overwrite vanilla function to remove the line which removes this skill upon being used
	// Instead we set IsHidden to true and in shoot_bolt and shoot_stake we set its IsHidden to false
	o.onUse = function( _user, _targetTile	)
	{
		this.consumeAmmo();
		this.getItem().setLoaded(true);
		this.m.IsHidden = true;
		return true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsHidden = true;
	}
});
