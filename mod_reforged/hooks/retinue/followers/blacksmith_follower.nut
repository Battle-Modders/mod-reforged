::Reforged.HooksMod.hook("scripts/retinue/followers/blacksmith_follower", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// In Reforged player weapons will always drop, so this part of the blacksmith is now redundant to mention
		this.m.Effects[0] = ::MSU.String.replace(this.m.Effects[0] , ", weapons", "");
	}
});
