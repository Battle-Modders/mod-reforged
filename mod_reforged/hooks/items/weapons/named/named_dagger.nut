::Reforged.HooksMod.hook("scripts/items/weapons/named/named_dagger", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/rondel_dagger";
		__original();
	}
});
