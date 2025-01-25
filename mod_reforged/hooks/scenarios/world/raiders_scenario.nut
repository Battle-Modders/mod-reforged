::Reforged.HooksMod.hook("scripts/scenarios/world/rangers_scenario", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Descriptions += "[color=#bcad8c]Adrenaline:[/color] All recruits have access to the Adrenaline perk.";
	}

	q.onHired = @(__original) function( _bro )
	{
		__original(_bro);
		_bro.getPerkTree().addPerk("perk.adrenaline");
	}
});
