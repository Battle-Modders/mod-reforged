::Reforged.HooksMod.hook("scripts/retinue/followers/drill_sergeant_follower", function(q) {
	q.create = @(__original) function ()
	{
		__original();
		this.m.Effects[0] = "Makes your men gain 40% more experience at level 1, with 4% less at each further level"
		this.m.Requirements.clear()		// We remove all Requirements, atleast up until the Retinue Rework
	}
});
