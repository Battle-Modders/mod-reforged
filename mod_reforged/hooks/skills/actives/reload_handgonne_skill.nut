::mods_hookExactClass("skills/actives/reload_handgonne_skill", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsRemovedAfterBattle = false;
	}

	// Overwrite vanilla function to set IsHidden to false instead of removing the skill
	// Necessary for custom skill costs for each weapon
	o.onUse = function( _user, _targetTile	)
	{
		this.consumeAmmo();
		this.getItem().setLoaded(true);
		this.m.IsHidden = true;
		return true;
	}
});
