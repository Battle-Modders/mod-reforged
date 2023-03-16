::mods_hookExactClass("items/helmets/nasal_helmet_with_closed_mail", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.StaminaModifier = -15;
	}
});
