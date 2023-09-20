::Reforged.HooksMod.hook("scripts/ambitions/ambitions/defeat_goblin_location_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_52.png";		// Hate against Greenskins
	}
});
