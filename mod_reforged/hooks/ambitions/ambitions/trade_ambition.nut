::Reforged.HooksMod.hook("scripts/ambitions/ambitions/trade_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_19.png";		// Peddler
	}
});
