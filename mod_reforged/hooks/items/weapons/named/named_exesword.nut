::Reforged.HooksMod.hook("scripts/items/weapons/named/named_exesword", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/exesword";
	q.create = @(__original) { function create()
	{
		__original();
		this.m.NameList = this.Const.Strings.RF_ExeswordNames;
		this.m.Description = "An expertly honed executioner\'s blade that ensures a painless demise. The ornately decorated blade suggests it has been used to sever many a noble neck.";
	}}.create;

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
