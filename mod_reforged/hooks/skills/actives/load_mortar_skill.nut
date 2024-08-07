::Reforged.HooksMod.hook("scripts/skills/actives/load_mortar_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Load a large shell into an adjacent mortar.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Can only be used once every " + ::MSU.Text.colorNegative(this.m.Cooldown) + " [turns|Concept.Turn]")
		});
		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used when [engaged|Concept.ZoneOfControl] in melee"))
			});
		}
		return ret;
	}
});
