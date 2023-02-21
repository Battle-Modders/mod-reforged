::mods_hookExactClass("items/weapons/staff_sling", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
		this.addWeaponType(::Const.Items.WeaponType.Sling);
	}
});
