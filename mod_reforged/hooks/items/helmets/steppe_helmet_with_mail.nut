::mods_hookExactClass("items/helmets/steppe_helmet_with_mail", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 1500;
		this.m.StaminaModifier = -11;
	}
});
