::Reforged.HooksMod.hook("scripts/skills/actives/sweep_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Swing your fists in a wide arc, hitting up to three adjacent characters in counter-clockwise order!";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Can hit up to " + ::MSU.Text.colorPositive(3) + " targets")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will knock back targets who are not immune to being knocked back or being rooted. Upon being knocked back, the targets lose the [Shieldwall|Skill+shieldwall_effect], [Spearwall|Skill+spearwall_effect] and [Riposte|Skill+riposte_effect] effects")
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Targets immune to being knocked back or rooted are [staggered|Skill+staggered_effect] instead")
		});
		return ret;
	}}.getTooltip;

	::Reforged.HooksHelper.moveDamageToOnAnySkillUsed(q);
});
