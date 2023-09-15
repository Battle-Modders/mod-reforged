this.rf_centurion_command_effect <- ::inherit("scripts/skills/effects/aura_abstract_effect", {
	m = {
		InitiativeBonus = 30
	},
	function create()
	{
		this.aura_abstract_effect.create();
		this.m.ID = "effects.rf_centurion_command";
		this.m.Name = "Centurion Command";
		this.m.Description = "This character is in the presence of a Centurion.";
		this.m.Icon = "skills/rf_centurion_command_effect.png";
		this.m.IconMini = "rf_centurion_command_effect_mini";
		this.m.Overlay = "rf_centurion_command_effect";
		this.m.AuraScript = "scripts/skills/perks/perk_rf_centurion";
		this.m.AuraID = "perk.rf_centurion";
		this.m.AuraRange = 6;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.InitiativeBonus) + " [Initiative|Concept.Initiative")
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (this.getAuraProvider() != null)
		{
			_properties.Initiative += this.m.InitiativeBonus;
		}
	}
});
