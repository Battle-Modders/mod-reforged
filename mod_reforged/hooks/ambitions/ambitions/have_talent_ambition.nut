::Reforged.HooksMod.hook("scripts/ambitions/ambitions/have_talent_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/rf_discovered_talent.png";
	}
});
