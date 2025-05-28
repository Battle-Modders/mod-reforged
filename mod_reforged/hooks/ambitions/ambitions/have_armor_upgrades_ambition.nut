::Reforged.HooksMod.hook("scripts/ambitions/ambitions/have_armor_upgrades_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "skills/passive_03.png";		// Chainmail Icon
	}}.create;
});
