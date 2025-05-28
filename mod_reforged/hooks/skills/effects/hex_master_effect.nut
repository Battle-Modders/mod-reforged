::Reforged.HooksMod.hook("scripts/skills/effects/hex_master_effect", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "This character has cursed a victim to suffer all the pain inflicted upon this character - a strong deterrent against those who would have hostile intentions.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();

		if (!::MSU.isNull(this.m.Slave) && this.m.Slave.isAlive())
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/orientation/" + this.m.Slave.getOverlayImage() + ".png",
				text = "Victim: " + this.m.Slave.getName()
			});
		}

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("All incoming [Hitpoints|Concept.Hitpoints] damage is inflicted in full to the victim as well")
		});
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire in " + ::MSU.Text.colorNegative(this.m.TurnsLeft) + " [turns|Concept.Turn]")
		});

		return ret;
	}}.getTooltip;
});
