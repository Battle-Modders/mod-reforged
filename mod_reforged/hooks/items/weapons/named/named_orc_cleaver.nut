::mods_hookExactClass("items/weapons/named/named_orc_cleaver", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/greenskins/orc_cleaver";
		create();
	}
});
