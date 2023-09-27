::Reforged.HooksMod.hook("scripts/items/weapons/named/named_polehammer", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/polehammer";
		__original();
	}
});
