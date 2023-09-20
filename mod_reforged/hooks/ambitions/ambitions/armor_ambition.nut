::Reforged.HooksMod.hook("scripts/ambitions/ambitions/armor_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_33.png";		// Hedge Knight
	}
});
