::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_plated_mail_hauberk", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 200; // vanilla 180
		this.m.ConditionMax = 200; // vanilla 180
		this.m.StaminaModifier = -26; // vanilla -22
	}}.create;
});
