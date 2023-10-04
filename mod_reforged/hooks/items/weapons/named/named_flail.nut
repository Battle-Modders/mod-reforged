::Reforged.HooksMod.hook("scripts/items/weapons/named/named_flail", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/flail";
		__original();
	}
});
