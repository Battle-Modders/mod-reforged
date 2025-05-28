::Reforged.HooksMod.hook("scripts/ambitions/ambitions/defeat_undead_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_78.png";		// Oathtaker Undead
	}}.create;
});
