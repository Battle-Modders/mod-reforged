::Reforged.HooksMod.hook("scripts/skills/actives/barbarian_fury_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Icon = "skills/active_175.png";
		this.m.IconDisabled = "skills/active_175_sw.png";
	}
});
