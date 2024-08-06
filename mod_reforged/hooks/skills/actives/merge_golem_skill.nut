::Reforged.HooksMod.hook("scripts/skills/actives/merge_golem_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Grow larger by bringing together the living sands and stone around you!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Fully heals all [Hitpoints|Concept.Hitpoints]")
		});

		local entityType = ::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()) ? ::Const.EntityType.SandGolem : this.getContainer().getActor().getType();
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Consumes 2 adjacent " + ::Const.Strings.EntityNamePlural[entityType] + " and makes you [grow|Skill+golem_racial] larger")
		});
		return ret;
	}
});
