::Reforged.HooksMod.hook("scripts/ambitions/ambitions/defeat_holywar_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_80.png";		// Oathtaker Holywar
	}
});
