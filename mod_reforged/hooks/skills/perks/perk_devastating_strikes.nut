::Reforged.HooksMod.hook("scripts/skills/perks/perk_devastating_strikes", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Icon = "ui/perks/perk_devastating_strikes.png"; // Art added by Reforged. In vanilla it uses skills/passive_03.png
	}}.create;
});
