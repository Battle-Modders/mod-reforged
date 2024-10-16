::Reforged.HooksMod.hook("scripts/skills/actives/insects_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Summon a swarm of insects to surround an enemy, reducing their ability to focus on combat!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target gains the [Swarm of Insects|Skill+insect_swarm_effect] effect")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		});
		return ret;
	}
});
