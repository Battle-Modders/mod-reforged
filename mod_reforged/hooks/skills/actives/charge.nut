::Reforged.HooksMod.hook("scripts/skills/actives/charge", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Hurl yourself forward, crashing into your enemies with overwhelming force!";
	}}.create;

	// Vanilla has a getTooltip function defined for this skill but it doesn't provide all the details
	// so we overwrite it to produce a better tooltip overall
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Move to the target tile")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Has a " + ::MSU.Text.colorPositive("100%") + " chance to stun a random adjacent enemy upon arrival, reduced by the defense granted by target\'s shield and [Shieldwall|Skill+shieldwall_effect]")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
			}
		]);

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Cannot be used when [engaged|Concept.ZoneOfControl] in melee")
			});
		}

		return ret;
	}}.getTooltip;
});
