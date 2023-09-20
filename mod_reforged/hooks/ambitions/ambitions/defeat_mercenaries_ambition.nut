::Reforged.HooksMod.hook("scripts/ambitions/ambitions/defeat_mercenaries_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/orientation/mercenary_orientation.png";
	}
});
