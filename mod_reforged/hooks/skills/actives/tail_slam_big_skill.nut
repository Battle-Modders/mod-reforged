::Reforged.HooksMod.hook("scripts/skills/actives/tail_slam_big_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla has the name Tail Slam for this skill which is the same as the name for tail_slam_skill
		// We give it a unique name to help differentiate the two skills
		this.m.Name = "Tail Thresh";
		// Vanilla is missing a description for this skill
		this.m.Description = "Swing your tail in a reckless round swing, threshing all the targets around you, friend and foe alike!";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
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
	}}.getTooltip;
});
