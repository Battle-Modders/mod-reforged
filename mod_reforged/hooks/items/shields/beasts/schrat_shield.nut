::mods_hookExactClass("items/shields/beasts/schrat_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IconLarge = "shields/inventory_named_shield_08.png";
		this.m.Icon = "shields/icon_named_shield_08.png";
	}
});
