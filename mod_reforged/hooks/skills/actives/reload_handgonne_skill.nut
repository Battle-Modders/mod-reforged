::Reforged.HooksMod.hook("scripts/skills/actives/reload_handgonne_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IsRemovedAfterBattle = false;
	}

	// Overwrite vanilla function to prevent removal of this skill
	q.onUse = @(__original) function( _user, _targetTile	)
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
});
