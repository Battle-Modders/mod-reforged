::Reforged.HooksMod.hook("scripts/items/weapons/named/named_billhook", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/billhook";
		__original();
	}
});
