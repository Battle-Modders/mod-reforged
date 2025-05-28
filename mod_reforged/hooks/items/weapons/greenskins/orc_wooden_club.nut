::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/orc_wooden_club", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;
});
