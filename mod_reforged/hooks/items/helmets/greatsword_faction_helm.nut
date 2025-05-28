::Reforged.HooksMod.hook("scripts/items/helmets/greatsword_faction_helm", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 2000; // vanilla 850
	}}.create;
});
