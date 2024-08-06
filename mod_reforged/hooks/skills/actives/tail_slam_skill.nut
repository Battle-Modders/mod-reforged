::Reforged.HooksMod.hook("scripts/skills/actives/tail_slam_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Slam your tail from above with full force to smash the target to bits.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will randomly either [daze|Skill+dazed_effect], [stun|Skill+stunned_effect] or knock back the target")
			}
		]);
		return ret;
	}
});
