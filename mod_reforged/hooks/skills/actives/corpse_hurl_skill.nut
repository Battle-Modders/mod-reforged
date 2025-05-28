::Reforged.HooksMod.hook("scripts/skills/actives/corpse_hurl_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Throw a decayed mass at a target tile, dealing damage on impact to all adjacent characters and leaving behind a corpse at the target location.");
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
