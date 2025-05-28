::Reforged.HooksMod.hook("scripts/ambitions/ambitions/have_talent_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/perk_rf_discovered_talent.png";
	}}.create;
});
