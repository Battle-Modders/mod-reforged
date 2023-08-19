::mods_hookExactClass("items/armor/mail_shirt", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.StaminaModifier = -13;
	}
});
