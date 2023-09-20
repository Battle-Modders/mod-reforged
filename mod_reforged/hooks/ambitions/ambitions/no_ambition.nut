::Reforged.HooksMod.hook("scripts/ambitions/ambitions/no_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "";		// no icon
	}
});
