::Reforged.HooksMod.hook("scripts/skills/actives/flesh_pull_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Harnessing dark forces, you pull a target toward a corpse or allied flesh golem that is at most 3 tiles away, [staggering|Skill+staggered_effect] it on arrival.");
	}}.create;

	// Overwrite, because Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		});

		return ret;
	}}.getTooltip;
});
