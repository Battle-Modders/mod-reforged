::Reforged.HooksMod.hook("scripts/scenarios/world/starting_scenario", function(q) {
	// If true then perk trees of starting bros using dynamic map are rebuilt after spawning
	q.m.RF_RebuildPerkTreeAfterSpawn <- true;
});

::Reforged.HooksMod.hookTree("scripts/scenarios/world/starting_scenario", function(q) {
	q.onSpawnPlayer = @(__original) function()
	{
		__original();

		if (this.m.RF_RebuildPerkTreeAfterSpawn)
		{
			// For each bro in the player party, if the bro's background uses a dynamic perk tree instead of a fixed template one,
			// we regenerate the perk tree so that all the factors such as equipped weapon etc. are taken into account.
			foreach (bro in ::World.getPlayerRoster().getAll())
			{
				if (bro.getBackground().createPerkTreeBlueprint().getTemplate() == null)
				{
					bro.getPerkTree().build();
				}
			}
		}
	}
});
