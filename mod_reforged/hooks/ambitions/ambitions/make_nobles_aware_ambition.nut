::Reforged.HooksMod.hook("scripts/ambitions/ambitions/make_nobles_aware_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_08.png";		// Disowned Noble / Broken Crown
	}}.create;
});
