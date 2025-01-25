::Reforged.HooksMod.hook("scripts/scenarios/world/militia_scenario", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Descriptions += "[color=#bcad8c]Militia:[/color] All recruits have access to the Militia perk group.";
	}

	q.onSpawnAssets = @(__original) function()
	{
		__original();
		foreach (bro in ::World.getPlayerRoster().getAll())
		{
			bro.getPerkTree().addPerkGroup("pg.rf_militia");
		}
	}

	q.onHired = @(__original) function( _bro )
	{
		__original(_bro);
		_bro.getPerkTree().addPerkGroup("pg.rf_militia");
	}
});
