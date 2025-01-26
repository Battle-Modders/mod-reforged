::Reforged.HooksMod.hook("scripts/scenarios/world/raiders_scenario", function(q) {
	q.create = @(__original) function()
	{
		__original();
		local additionalDesc = "\n[color=#bcad8c]Adrenaline:[/color] All recruits have access to the Adrenaline perk.";
		if (this.m.Description.slice(-4) == "[/p]")
		{
			this.m.Description = this.m.Description.slice(0, -4) + additionalDesc + "[/p]";
		}
		else
		{
			this.m.Description += additionalDesc;
		}
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
