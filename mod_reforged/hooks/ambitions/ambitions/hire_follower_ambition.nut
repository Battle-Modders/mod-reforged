::Reforged.HooksMod.hook("scripts/ambitions/ambitions/hire_follower_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_16.png";		// Servant
	}}.create;
});
