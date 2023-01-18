::mods_hookExactClass("skills/actives/shoot_stake", function(o) {
	// Overwrite vanilla function to set the IsHidden of reload_bolt to false instead of adding it
	// Because we have changed reload_bolt to no longer remove itself in its onUse and instead become Hidden
	o.onUse = function( _user, _targetTile	)
	{
		local ret = this.attackEntity(_user, _targetTile.getEntity());
		this.getItem().setLoaded(false);

		local reload = this.getContainer().getSkillByID("actives.reload_bolt");
		if (reload != null)
		{
			reload.m.IsHidden = false;
		}

		return ret;
	}

	// Overwrite the vanilla function to prevent removal of reload_bolt
	o.onRemoved = function()
	{
	}
});
