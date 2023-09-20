::Reforged.HooksMod.hook("scripts/ambitions/ambitions/ranged_mastery_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_29.png";		// Fletcher
	}
});

