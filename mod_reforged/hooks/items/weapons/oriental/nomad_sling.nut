::Reforged.HooksMod.hook("scripts/items/weapons/oriental/nomad_sling", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
		this.addWeaponType(::Const.Items.WeaponType.Sling);
	}
});
