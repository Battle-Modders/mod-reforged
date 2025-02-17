::Reforged.HooksMod.hook("scripts/scenarios/world/militia_scenario", function(q) {
	q.create = @(__original) function()
	{
		__original();
		local additionalDesc = "\n[color=#bcad8c]Militia:[/color] All recruits have access to the Militia perk group.";
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
		_perkTree.addPerkGroup("pg.rf_militia");
	}
});
