::Reforged.HooksMod.hook("scripts/items/weapons/named/named_bladed_pike", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/ancient/bladed_pike";
		__original();
	}
});
