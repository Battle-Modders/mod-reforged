::Reforged.HooksMod.hook("scripts/skills/actives/strike_down_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IsDamagingPoise = true;
		this.m.IsStunningFromPoise = true;
	}
});
