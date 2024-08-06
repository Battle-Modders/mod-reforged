::Reforged.HooksMod.hook("scripts/skills/effects/drums_of_war_effect", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "This character is feeling more energetic, thanks to the vigorous rhythm of his allies' war drums."
		// In vanilla it is hidden but we reveal it because we have custom description and tooltip for it.
		this.m.IsHidden = false;
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString("Built [Fatigue|Concept.Fatigue] is reduced by " + ::MSU.Text.colorGreen("15") + " when this effect is received")
		});
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Cannot receive this effect more than once per [turn|Concept.Turn]")
		});

		return ret;
	}
});
