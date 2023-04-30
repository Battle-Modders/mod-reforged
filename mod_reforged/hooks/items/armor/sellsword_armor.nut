::mods_hookExactClass("items/armor/sellsword_armor", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.StaminaModifier = -30;
	}
});
