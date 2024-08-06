::Reforged.HooksMod.hook("scripts/skills/actives/tail_slam_split_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla has the name Tail Slam for this skill which is the same as the name for tail_slam_skill
		// We give it a unique name to help differentiate the two skills
		this.m.Name = "Tail Split";
		// Vanilla is missing a description for this skill
		this.m.Description = "Slam your tail in a wide-swinging overhead attack that can hit two tiles in a straight line.";
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
				text = ::Reforged.Mod.Tooltips.parseString("Will randomly either [daze|Skill+dazed_effect] or [stun|Skill+stunned_effect] the target")
			}
		]);
		return ret;
	}
});
