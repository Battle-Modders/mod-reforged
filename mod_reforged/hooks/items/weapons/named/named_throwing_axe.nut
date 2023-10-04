::Reforged.HooksMod.hook("scripts/items/weapons/named/named_throwing_axe", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/throwing_axe";
		__original();
	}
});
