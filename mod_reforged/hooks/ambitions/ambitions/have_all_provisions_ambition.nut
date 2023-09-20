::Reforged.HooksMod.hook("scripts/ambitions/ambitions/have_all_provisions_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_07.png";		// Glutton
	}
});
