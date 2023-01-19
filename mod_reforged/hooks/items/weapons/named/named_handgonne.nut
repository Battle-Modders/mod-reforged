::mods_hookExactClass("items/weapons/named/named_handgonne", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/oriental/handgonne";
		create();
	}
});
