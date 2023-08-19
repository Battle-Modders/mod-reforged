::mods_hookExactClass("items/armor/basic_mail_shirt", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.StaminaModifier = -11;
	}
});
