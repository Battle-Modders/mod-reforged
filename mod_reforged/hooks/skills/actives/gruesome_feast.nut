::Reforged.HooksMod.hook("scripts/skills/actives/gruesome_feast", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Feast on a corpse to heal yourself and grow larger!";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/health.png",
			text = ::Reforged.Mod.Tooltips.parseString("All [Hitpoints|Concept.Hitpoints] and [injuries|Concept.TemporaryInjury] are fully healed")
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Gain the [Feasted|Skill+gruesome_feast_effect] effect")
		});
		return ret;
	}}.getTooltip;
});
