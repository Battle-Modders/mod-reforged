::Reforged.HooksMod.hook("scripts/skills/actives/teleport_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Travel between the planes to appear at another location in this dimension.";
	}}.create;

	// Vanilla getTooltip for this skill doesn't mention the terrain transformation
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will transform the terrain around the beginning and end of the teleportation to Snow")
		});
		return ret;
	}}.getTooltip;
});
