::Reforged.HooksMod.hook("scripts/skills/actives/reload_bolt", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IsRemovedAfterBattle = false;
		this.m.ActionPointCost = 5;	// In Vanilla this is 4
	}

	// Overwrite vanilla function to prevent removal of this skill
	q.onUse = @() function( _user, _targetTile	)
	{
		this.consumeAmmo();
		this.getItem().setLoaded(true);
		return true;
	}

	q.isHidden <- function()
	{
		if (!this.getContainer().getActor().isPlacedOnMap()) return true;	// In the character screen this is always hidden

		return this.getItem().isLoaded();
	}

	q.onUse = @(__original) function( _user, _targetTile )
	{
		local ret = __original(_user, _targetTile);
		this.getContainer().add(::new("scripts/skills/effects/rf_reload_disorientation_effect"));
		return ret;
	}
});
