::mods_hookExactClass("items/weapons/named/named_qatal_dagger", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/oriental/qatal_dagger";
		create();
	}
});
