::Reforged.HooksMod.hook("scripts/skills/actives/reload_handgonne_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IsRemovedAfterBattle = false;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;	// Players expect this skill to come earlier than most other active skills because of muscle memory, so we move it forward to be immediately after the shoot skill
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
});
