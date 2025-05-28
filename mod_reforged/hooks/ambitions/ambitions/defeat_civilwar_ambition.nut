::Reforged.HooksMod.hook("scripts/ambitions/ambitions/defeat_civilwar_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_85.png";		// Oathtaker Noble
	}}.create;
});
