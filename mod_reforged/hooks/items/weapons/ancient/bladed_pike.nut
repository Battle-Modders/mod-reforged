::Reforged.HooksMod.hook("scripts/items/weapons/ancient/bladed_pike", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 7;
	}
});
