::Reforged.HooksMod.hook("scripts/ambitions/ambitions/defeat_undead_location_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_50.png";		// Hate for Undead
	}
});
