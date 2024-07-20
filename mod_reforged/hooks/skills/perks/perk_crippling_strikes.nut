::Reforged.HooksMod.hook("scripts/skills/perks/perk_crippling_strikes", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_57.png";	// In vanilla it uses the 'Executioner (CoupDeGrace)' Icon but there it doesn't matter. However we list this perk in the tactical tooltip.
	}
});
