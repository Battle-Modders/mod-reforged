::Reforged.HooksMod.hook("scripts/skills/actives/fire_mortar_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Fire a shell high in the air to wreak havoc upon returning to earth with a blasting impact.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will mark a tile and its surrounding tiles for impact for this character\'s next [turn|Concept.Turn]. Upon impact, characters in the tiles take damage and may be [Shellshocked|Skill+shellshocked_effect]")
		});
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Can only be used once every " + ::MSU.Text.colorNegative(this.m.Cooldown) + " [turns|Concept.Turn]")
		});
		return ret;
	}
});
