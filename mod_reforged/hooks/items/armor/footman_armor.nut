::Reforged.HooksMod.hook("scripts/items/armor/footman_armor", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "A transitional armor consisting of a long mail shirt and a riveted leather gambeson."; // Fixes vanilla typo "rivetted" to "riveted".
	}
});
