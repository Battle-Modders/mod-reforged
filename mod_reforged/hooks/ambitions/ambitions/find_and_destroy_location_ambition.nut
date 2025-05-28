::Reforged.HooksMod.hook("scripts/ambitions/ambitions/find_and_destroy_location_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/perk_25.png";		// Footwork / Yellow Footsteps
	}}.create;
});
