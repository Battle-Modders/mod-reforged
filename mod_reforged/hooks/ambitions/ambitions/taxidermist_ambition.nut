::Reforged.HooksMod.hook("scripts/ambitions/ambitions/taxidermist_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "skills/status_effect_97.png";		// Poison
	}
});
