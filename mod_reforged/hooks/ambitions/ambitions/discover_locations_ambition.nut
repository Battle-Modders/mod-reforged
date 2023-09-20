::Reforged.HooksMod.hook("scripts/ambitions/ambitions/discover_locations_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/perk_23.png";		// Pathfinder
	}
});
