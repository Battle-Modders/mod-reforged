::Reforged.HooksMod.hook("scripts/skills/actives/sweep_zoc_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Swing your fists at a character who tries to move [away|Concept.ZoneOfControl] from you.");
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will [stagger|Skill+staggered_effect] the target on a hit")
		});
		return ret;
	}}.getTooltip;
});
