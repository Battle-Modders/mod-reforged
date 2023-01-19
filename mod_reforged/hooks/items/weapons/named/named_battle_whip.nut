::mods_hookExactClass("items/weapons/named/named_battle_whip", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/battle_whip";
		create();
	}
});
