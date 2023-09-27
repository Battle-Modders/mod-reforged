::Reforged.HooksMod.hook("scripts/skills/actives/thresh", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IsDamagingPoise = true;
		this.m.IsStunningFromPoise = true;
	}
});
