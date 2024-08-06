::Reforged.HooksMod.hook("scripts/skills/actives/darkflight", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Transform into a swarm of bats to quickly navigate the field of battle ignoring [Zone of Control|Concept.ZoneOfControl].");
	}
});
