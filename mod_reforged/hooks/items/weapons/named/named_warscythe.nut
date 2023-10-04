::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warscythe", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/ancient/warscythe";
		__original();
	}
});
