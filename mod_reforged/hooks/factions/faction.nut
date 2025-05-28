::Reforged.HooksMod.hook("scripts/factions/faction", function (q) {
	// Overwrite, because we only want to hide certain settlements at 50 relation, if they didn't have a recent relationship change with the player
	q.isHidden = @() { function isHidden()
	{
		return this.m.IsHidden || (this.m.IsHiddenIfNeutral && this.m.PlayerRelation == 50 && this.m.PlayerRelationChanges.len() == 0);
	}}.isHidden;
});
