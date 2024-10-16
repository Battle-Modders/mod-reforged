::Reforged.HooksMod.hook("scripts/skills/actives/miasma_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Summon a toxic miasma in the target area dealing damage to anything that lives and breathes!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The targeted tiles gain miasma that lasts " + ::MSU.Text.colorPositive(3) + " [rounds|Concept.Round]")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("All characters except the undead receive " + ::MSU.Text.colorNegative(5) + " - " + ::MSU.Text.colorNegative(10) + " damage when they end their [turn|Concept.Turn] in the miasma")
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Blows away existing tile effects like Fire or Smoke")
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		});
		return ret;
	}
});
