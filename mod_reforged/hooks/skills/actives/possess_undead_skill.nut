::Reforged.HooksMod.hook("scripts/skills/actives/possess_undead_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Concentrate on one of your wiedergangers to grant him great boons!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("You gain the [Possessing Undead|Skill+possessing_undead_effect] effect and the target gains the [Possessed Undead|Skill+possessed_undead_effect] effect")
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
