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
		local ret = this.skill.getDefaultUtilityTooltip();

		if (!::MSU.isNull(this.m.Slave) && !::MSU.isNull(this.m.Slave.getContainer()))
		{
			local victim = this.m.Slave.getContainer().getActor();
			if (this.m.Slave.isAlive())
			{
				ret.push({
					id = 10,
					type = "text",
					icon = "ui/orientation/" + victim.getOverlayImage() + ".png",
					text = "Victim: " + victim.getName(),
				});
			}
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
