::Reforged.HooksMod.hookTree("scripts/scenarios/world/starting_scenario", function(q) {
	q.onSpawnPlayer = @(__original) function()
	{
		__original();

		// For each bro in the player party, if the bro's background uses a dynamic perk tree instead of a fixed template one,
		// we regenerate the perk tree so that all the factors such as equipped weapon etc. are taken into account.
		foreach (bro in ::World.getPlayerRoster().getAll())
		{
			if (::new(::IO.scriptFilenameByHash(bro.getBackground().ClassNameHash)).m.PerkTree.getTemplate() == null)
			{
				bro.getPerkTree().build();
			}
		}
	}
});
