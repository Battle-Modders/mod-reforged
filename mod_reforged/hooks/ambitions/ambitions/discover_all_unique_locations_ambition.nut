::Reforged.HooksMod.hook("scripts/ambitions/ambitions/discover_all_unique_locations_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/perk_21.png";		// Student
	}}.create;
});
