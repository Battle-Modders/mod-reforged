::mods_hookExactClass("items/armor/ancient/ancient_plated_mail_hauberk", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 200;
		this.m.ConditionMax = 200;
		this.m.StaminaModifier = -26;
	}
});
