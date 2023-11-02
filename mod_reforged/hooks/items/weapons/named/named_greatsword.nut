::Reforged.HooksMod.hook("scripts/items/weapons/named/named_greatsword", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/greatsword";
		__original();
		this.m.Variant = this.Math.rand(1, 4);
		this.updateVariant();
	}
});
