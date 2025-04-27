::Reforged.HooksMod.hook("scripts/skills/perks/perk_stalwart", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "ui/perks/perk_stalwart.png"; // Art added by Reforged. In vanilla it uses skills/passive_03.png
	}
});
