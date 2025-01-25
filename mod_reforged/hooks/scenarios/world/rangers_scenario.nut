::Reforged.HooksMod.hook("scripts/scenarios/world/rangers_scenario", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Descriptions += "[color=#bcad8c]Pathfinders:[/color] All recruits have access to the Pathfinder perk.";
	}

	q.onSpawnAssets = @(__original) function()
	{
		__original();
		foreach (bro in ::World.getPlayerRoster().getAll())
		{
			bro.getPerkTree().addPerk("perk.pathfinder");
		}
	}

	q.onHired = @(__original) function( _bro )
	{
		__original(_bro);
		_bro.getPerkTree().addPerk("perk.pathfinder");
	}
});
