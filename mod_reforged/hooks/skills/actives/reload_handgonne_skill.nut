::Reforged.HooksMod.hook("scripts/skills/actives/reload_handgonne_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IsRemovedAfterBattle = false;
		this.m.ActionPointCost = 8;	// In Vanilla this is 9
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		local oldActionPointCost = this.m.ActionPointCost;
		__original(_properties);
		this.m.ActionPointCost = oldActionPointCost;	// We prevent the action point cost from being manipulated by vanilla
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
