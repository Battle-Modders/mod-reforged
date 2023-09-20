::Reforged.HooksMod.hook("scripts/ambitions/ambitions/sergeant_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/perk_42.png";		// Rally the Troops
	}
});
