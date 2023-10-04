::Reforged.HooksMod.hook("scripts/items/weapons/ancient/warscythe", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
	}
});
