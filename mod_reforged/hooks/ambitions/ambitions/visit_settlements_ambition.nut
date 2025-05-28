::Reforged.HooksMod.hook("scripts/ambitions/ambitions/visit_settlements_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_46.png";		// Messenger
	}}.create;
});
