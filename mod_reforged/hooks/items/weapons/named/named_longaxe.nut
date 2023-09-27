::Reforged.HooksMod.hook("scripts/items/weapons/named/named_longaxe", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/longaxe";
		__original();
	}
});
