::Reforged.HooksMod.hook("scripts/skills/actives/serpent_hook_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Wrap your body around the target and pull them towards a more vulnerable position!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will grab the target and pull it to a tile next to you")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target becomes [Staggered|Skill+staggered_effect]")
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target loses the [Shieldwall|Skill+shieldwall_effect], [Spearwall|Skill+spearwall_effect] and [Riposte|Skill+riposte_effect] effects")
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target will receive damage when being pulled to a lower elevation")
		});
		ret.push({
			id = 14,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		});
		return ret;
	}
});
