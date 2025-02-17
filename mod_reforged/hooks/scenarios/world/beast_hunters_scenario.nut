::Reforged.HooksMod.hook("scripts/scenarios/world/beast_hunters_scenario", function(q) {
	q.create = @(__original) function()
	{
		__original();
		local additionalDesc = "\n[color=#bcad8c]Brave Hunters:[/color] All recruits have access to the Fortified Mind perk.";
		if (this.m.Description.slice(-4) == "[/p]")
		{
			this.m.Description = this.m.Description.slice(0, -4) + additionalDesc + "[/p]";
		}
		else
		{
			this.m.Description += additionalDesc;
		}
	}

	q.onBuildPerkTree = @(__original) function( _perkTree )
	{
		__original(_perkTree);
		// We remove it and add it so that it goes on the first tier
		if (_perkTree.hasPerk("perk.fortified_mind"))
		{
			_perkTree.removePerk("perk.fortified_mind");
		}
		_perkTree.addPerk("perk.fortified_mind");
	}
});
