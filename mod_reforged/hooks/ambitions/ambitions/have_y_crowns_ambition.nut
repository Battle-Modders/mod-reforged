::Reforged.HooksMod.hook("scripts/ambitions/ambitions/have_y_crowns_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_10.png";		// Sellsword
	}}.create;
});
