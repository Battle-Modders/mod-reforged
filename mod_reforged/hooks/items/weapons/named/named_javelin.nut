::Reforged.HooksMod.hook("scripts/items/weapons/named/named_javelin", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/javelin";
		__original();
	}
});
