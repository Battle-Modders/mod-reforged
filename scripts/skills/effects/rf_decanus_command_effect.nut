this.rf_decanus_command_effect <- ::inherit("scripts/skills/effects/aura_abstract_effect", {
	m = {},
	function create()
	{
		this.aura_abstract_effect.create();
		this.m.ID = "effects.rf_decanus_command";
		this.m.Name = "Decanus Command";
		this.m.Description = "This character is in the presence of a Decanus.";
		this.m.Icon = "skills/rf_decanus_command_effect.png";
		this.m.IconMini = "rf_decanus_command_effect_mini";
		this.m.Overlay = "rf_decanus_command_effect";
		this.m.AuraScript = "scripts/skills/perks/perk_rf_decanus";
		this.m.AuraID = "perk.rf_decanus";
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString("Can use [Shieldwall|Skill+shieldwall] for 0 Action Points")
		});

		return tooltip;
	}

	function onAfterUpdate( _properties )
	{
		if (this.getAuraProvider() != null)
		{
			local shieldwall = this.getContainer().getSkillByID("actives.shieldwall");
			if (shieldwall != null) shieldwall.m.ActionPointCost = 0;
		}
	}
});
