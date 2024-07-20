::Reforged.HooksMod.hook("scripts/skills/perks/perk_underdog", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_60.png";	// In vanilla it uses the 'Student' Icon but there it doesn't matter. However we list this perk in the tactical tooltip.
	}
});
