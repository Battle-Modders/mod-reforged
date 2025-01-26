::Reforged.HooksMod.hook("scripts/scenarios/world/raiders_scenario", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Descriptions += "[color=#bcad8c]Adrenaline:[/color] All recruits have access to the Adrenaline perk.";
	}

	q.onBuildPerkTree = @(__original) function( _bro )
	{
		__original(_bro);
		// We remove it and add it so that it goes on the first tier
		if (_bro.getPerkTree().hasPerk("perk.adrenaline"))
		{
			_bro.getPerkTree().removePerk("perk.adrenaline");
		}
		_bro.getPerkTree().addPerk("perk.adrenaline");
	}
});
