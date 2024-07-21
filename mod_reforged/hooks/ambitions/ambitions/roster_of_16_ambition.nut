::Reforged.HooksMod.hook("scripts/ambitions/ambitions/roster_of_16_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/perk_rf_strength_in_numbers.png";	// peasant militia icon
	}
});

