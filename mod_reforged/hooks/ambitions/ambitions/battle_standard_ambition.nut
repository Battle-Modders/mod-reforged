::Reforged.HooksMod.hook("scripts/ambitions/ambitions/battle_standard_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/perk_28.png";		// Inspiring Presence
	}
});
