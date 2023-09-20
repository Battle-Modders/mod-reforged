::Reforged.HooksMod.hook("scripts/ambitions/ambitions/have_z_renown_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_08.png";		// Disowned Noble / Broken Crown
	}
});
