::Reforged.HooksMod.hook("scripts/items/weapons/oriental/swordlance", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
		this.addWeaponType(::Const.Items.WeaponType.Sword);
	}
});
