::Reforged.HooksMod.hook("scripts/items/weapons/ancient/bladed_pike", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 7;
	}}.create;
});
