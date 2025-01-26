::Reforged.HooksMod.hook("scripts/scenarios/world/rangers_scenario", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Descriptions += "[color=#bcad8c]Pathfinders:[/color] All recruits have access to the Pathfinder perk.";
	}

	q.onBuildPerkTree = @(__original) function( _bro )
	{
		__original(_bro);
		// We remove it and add it so that it goes on the first tier
		if (_bro.getPerkTree().hasPerk("perk.pathfinder"))
		{
			_bro.getPerkTree().removePerk("perk.pathfinder");
		}
		_bro.getPerkTree().addPerk("perk.pathfinder");
	}
});
