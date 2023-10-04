::Reforged.HooksMod.hook("scripts/items/weapons/named/named_pike", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/pike";
		__original();
	}
});
