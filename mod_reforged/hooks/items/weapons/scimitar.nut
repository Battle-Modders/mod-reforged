::mods_hookExactClass("items/weapons/scimitar", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 4;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.RF_Southern;
	}
});
