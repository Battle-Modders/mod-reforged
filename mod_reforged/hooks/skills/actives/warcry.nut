::Reforged.HooksMod.hook("scripts/skills/actives/warcry", function(q) {
	q.create = @(__original) function()
	{
		__original();

		// VanillaFix: vanilla uses the wrong icon active_41
		this.m.Icon = "skills/active_49.png";
		this.m.IconDisabled = "skills/active_49_sw.png";
	}
});
