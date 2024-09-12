::Reforged.HooksMod.hook("scripts/items/weapons/throwing_spear", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
		this.m.Description = "Lighter than a common spear, but heavier than a javelin, this weapon is intended to be thrown over short distances."; // Remove the part about damaging shields

	}
});
