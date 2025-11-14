::Reforged.HooksMod.hook("scripts/skills/actives/darkflight", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Transform into a swarm of bats to quickly navigate the field of battle ignoring [Zone of Control.|Concept.ZoneOfControl]");
	}}.create;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		});

		return ret;
	}}.getTooltip;
});
