::Reforged.HooksMod.hook("scripts/items/weapons/billhook", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
		this.setWeaponType(::Const.Items.WeaponType.Axe);
	}
});
