::Reforged.HooksMod.hook("scripts/skills/actives/unleash_wolf", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Order = ::Const.SkillOrder.BeforeLast + 5;	// We want release-ables to be listed after break-free skills (which are BeforeLast)
	}}.create;
});
