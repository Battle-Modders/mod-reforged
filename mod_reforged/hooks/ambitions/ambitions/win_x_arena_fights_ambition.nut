::Reforged.HooksMod.hook("scripts/ambitions/ambitions/win_x_arena_fights_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_73.png";
	}
});
