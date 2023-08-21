::mods_hookExactClass("items/weapons/oriental/polemace", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
		this.m.FlipIconX = true;
		this.m.FlipIconLargeX = true;
	}
});
