::Reforged.HooksMod.hook("scripts/skills/perks/perk_student", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IsRefundable = false;
	}
});
