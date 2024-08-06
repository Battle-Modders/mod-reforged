::Reforged.HooksMod.hook("scripts/skills/actives/hyena_bite_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "An attack adept at piercing through armor to get to the flesh beneath!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Inflicts [Bleeding|Skill+bleeding_effect] when dealing at least " + ::MSU.Text.colorRed(::Const.Combat.MinDamageToApplyBleeding) + " damage to [Hitpoints|Concept.Hitpoints]")
		});
		return ret;
	}
});
