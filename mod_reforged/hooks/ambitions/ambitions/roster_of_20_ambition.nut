::Reforged.HooksMod.hook("scripts/ambitions/ambitions/roster_of_20_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/rf_strength_in_numbers.png";	// peasant militia icon
	}
});

