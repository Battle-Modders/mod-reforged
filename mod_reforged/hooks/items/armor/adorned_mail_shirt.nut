::mods_hookExactClass("items/armor/adorned_mail_shirt", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 1300;
		this.m.StaminaModifier = -15;
	}
});
