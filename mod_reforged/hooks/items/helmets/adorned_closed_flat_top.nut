::mods_hookExactClass("items/helmets/adorned_closed_flat_top_with_mail", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 2500;
	}
});
