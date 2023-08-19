::mods_hookExactClass("items/armor/adorned_warriors_armor", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 3000;
	}
});
