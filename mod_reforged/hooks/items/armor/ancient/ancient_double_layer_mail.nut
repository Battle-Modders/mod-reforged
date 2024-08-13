::mods_hookExactClass("items/armor/ancient/ancient_double_layer_mail", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 135;
		this.m.ConditionMax = 135;
	}
});
