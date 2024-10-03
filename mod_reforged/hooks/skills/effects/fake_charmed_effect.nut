::Reforged.HooksMod.hook("scripts/skills/effects/fake_charmed_effect", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// We change the name from vanilla "Charmed" to differentiate it from the real "Charmed" effect that players get
		this.m.Name = "Enthralled";
		// Vanilla is missing a description for this skill
		this.m.Description = "This character has been enthralled. They no longer have any control over their actions and are a puppet that has no choice but to obey his master.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+20") + " [Resolve|Concept.Bravery]")
		});
		return ret;
	}
});
