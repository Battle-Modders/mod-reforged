::Reforged.HooksMod.hook("scripts/items/weapons/named/named_greatsword", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/greatsword";
		__original();
	}
});
