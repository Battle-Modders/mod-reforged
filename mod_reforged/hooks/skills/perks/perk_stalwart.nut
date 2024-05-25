::Reforged.HooksMod.hook("scripts/skills/perks/perk_stalwart", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_18";	// Unused vanilla perk icon of an anvil
	}
});
