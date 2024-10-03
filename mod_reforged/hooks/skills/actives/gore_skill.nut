::Reforged.HooksMod.hook("scripts/skills/actives/gore_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Charge forward with unnatural spiritual energy and gore the enemy on your massive horns.";
	}

	// Vanilla getTooltip for this skill only has name, description and cost string
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will [stagger|Skill+staggered_effect] and knock back all targets around the target tile")
		});
		return ret;
	}
});
