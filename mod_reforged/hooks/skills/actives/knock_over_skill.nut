::Reforged.HooksMod.hook("scripts/skills/actives/knock_over_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IsDamagingPoise = true;
		this.m.IsStunningFromPoise = true;
	}
});
