::mods_hookExactClass("items/helmets/reinforced_mail_coif", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 600;
		this.m.StaminaModifier = -4;
	}
});
