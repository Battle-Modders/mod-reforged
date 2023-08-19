::mods_hookExactClass("items/armor/worn_mail_shirt", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 105;
		this.m.ConditionMax = 105;
	}
});
