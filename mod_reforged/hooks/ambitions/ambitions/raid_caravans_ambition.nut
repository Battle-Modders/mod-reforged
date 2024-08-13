::Reforged.HooksMod.hook("scripts/ambitions/ambitions/raid_caravans_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_12.png";		// Caravan Hand
	}
});
