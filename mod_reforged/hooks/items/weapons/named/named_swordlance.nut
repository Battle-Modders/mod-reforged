::Reforged.HooksMod.hook("scripts/items/weapons/named/named_swordlance", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/oriental/swordlance";
		__original();
	}
});
