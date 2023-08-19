::mods_hookExactClass("items/armor/noble_mail_armor", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 2000;
		this.m.Condition = 135;
		this.m.ConditionMax = 135;
		this.m.StaminaModifier = -12;
	}
});
