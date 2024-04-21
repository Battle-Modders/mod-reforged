::Reforged.HooksMod.hook("scripts/items/armor/armor", function(q) {
	q.onCombatStarted = @(__original) function()	// This should be implemented by MSU, see: https://github.com/MSUTeam/MSU/issues/347
	{
		__original();
		if (this.getUpgrade() != null)
		{
			this.getUpgrade().onCombatStarted();	// Vanilla Fix: this is never called in vanilla
		}
	}
});
