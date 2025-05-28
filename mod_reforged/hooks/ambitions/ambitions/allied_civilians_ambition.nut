::Reforged.HooksMod.hook("scripts/ambitions/ambitions/allied_civilians_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_32.png";		// Companion / Fist Bump
	}}.create;
});
