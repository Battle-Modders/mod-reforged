::Reforged.HooksMod.hook("scripts/skills/effects/possessing_undead_effect", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "This character has mysteriously taken direct control of a wiederganger.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();

		if (!::MSU.isNull(this.m.Possessed) && this.m.Possessed.isAlive())
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/orientation/" + this.m.Possessed.getOverlayImage() + ".png",
				text = "Possessing " + this.m.Possessed.getName()
			});
		}

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will be lost upon receiving " + ::MSU.Text.colorDamage(::Const.Combat.InjuryMinDamage) + " damage to [Hitpoints|Concept.Hitpoints] or if the possessed character dies")
		});

		return ret;
	}}.getTooltip;
});
