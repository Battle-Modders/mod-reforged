::Reforged.HooksMod.hook("scripts/ambitions/ambitions/fulfill_x_southern_contracts_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_47.png";		// Historian / Book + Feather
	}}.create;
});
