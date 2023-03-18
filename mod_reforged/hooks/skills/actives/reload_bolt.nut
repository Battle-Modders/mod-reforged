::mods_hookExactClass("skills/actives/reload_bolt", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsRemovedAfterBattle = false;
	}

	// Overwrite vanilla function to prevent removal of this skill
	o.onUse = function( _user, _targetTile	)
	{
		this.consumeAmmo();
		this.getItem().setLoaded(true);
		return true;
	}

	o.isHidden <- function()
	{
		if (!this.getContainer().getActor().isPlacedOnMap()) return true;	// In the character screen this is always hidden

		return this.getItem().isLoaded();
	}
});
