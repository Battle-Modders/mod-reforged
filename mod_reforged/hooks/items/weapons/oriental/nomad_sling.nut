::Reforged.HooksMod.hook("scripts/items/weapons/oriental/nomad_sling", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
		this.setWeaponType(::Const.Items.WeaponType.Sling | ::Const.Items.WeaponType.Throwing);
	}
});
