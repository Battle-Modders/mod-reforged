::Reforged.HooksMod.hook("scripts/skills/actives/knock_out", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IsDamagingPoise = true;
		this.m.IsStunningFromPoise = true;
	}
});
