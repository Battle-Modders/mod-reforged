::Reforged.HooksMod.hook("scripts/skills/actives/corpse_explosion_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Detonate a corpse or Flesh Cradle, destroying it in a gruesome explosion. The blast deals damage to any target standing on the corpse and all adjacent enemies and leaves a lingering miasma on all affected tiles.");
	}

	// Overwrite, because Vanilla uses a hard-coded implementation, instead of using getDefaultUtilityTooltip
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		});

		return ret;
	}
});
