::Reforged.HooksMod.hook("scripts/items/weapons/named/named_qatal_dagger", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/oriental/qatal_dagger";
		__original();
	}
});
