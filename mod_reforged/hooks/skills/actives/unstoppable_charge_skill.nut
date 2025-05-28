::Reforged.HooksMod.hook("scripts/skills/actives/unstoppable_charge_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Charge into a tile with unstoppable force, wreaking havoc in the area!";
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
				text = ::Reforged.Mod.Tooltips.parseString("Will move you into the target tile and randomly [stun|Skill+stunned_effect], or [stagger|Skill+staggered_effect] and knock back enemies around that tile")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Knocked back targets will lose the [Shieldwall|Skill+shieldwall_effect], [Spearwall|Skill+spearwall_effect] and [Riposte|Skill+riposte_effect] effects")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
			}
		]);
		return ret;
	}}.getTooltip;
});
