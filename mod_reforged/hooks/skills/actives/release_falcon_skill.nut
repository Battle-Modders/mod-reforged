::Reforged.HooksMod.hook("scripts/skills/actives/release_falcon_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Order = ::Const.SkillOrder.BeforeLast + 5;	// We want release-ables to be listed after break-free skills (which are BeforeLast)
	}
});
