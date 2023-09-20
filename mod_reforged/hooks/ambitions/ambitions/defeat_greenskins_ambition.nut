::Reforged.HooksMod.hook("scripts/ambitions/ambitions/defeat_greenskins_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_77.png";		// Oathtaker Orcs
	}
});
