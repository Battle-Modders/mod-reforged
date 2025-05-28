::Reforged.HooksMod.hook("scripts/ambitions/ambitions/discover_unique_locations_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "skills/status_effect_111.png";		// Disarmed / Red X
	}}.create;
});
