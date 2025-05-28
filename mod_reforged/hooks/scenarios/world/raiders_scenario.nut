::Reforged.HooksMod.hook("scripts/scenarios/world/raiders_scenario", function(q) {
	q.create = @(__original) { function create()
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
	}}.create;

	q.onBuildPerkTree = @(__original) { function onBuildPerkTree( _perkTree )
	{
		__original(_perkTree);
		// We remove it and add it so that it goes on the first tier
		if (_perkTree.hasPerk("perk.adrenaline"))
		{
			_perkTree.removePerk("perk.adrenaline");
		}
		_perkTree.addPerk("perk.adrenaline");
	}}.onBuildPerkTree;
});
