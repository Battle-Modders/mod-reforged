::Reforged.HooksMod.hook("scripts/ambitions/ambitions/hammer_mastery_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/perk_53.png";		// Hammer Mastery
	}}.create;
});
