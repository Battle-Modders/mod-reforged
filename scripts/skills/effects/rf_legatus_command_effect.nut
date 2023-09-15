this.rf_legatus_command_effect <- ::inherit("scripts/skills/effects/aura_abstract_effect", {
	m = {
		DamageMult = 1.1,
		DamageReceivedMult = 0.9,
		ResolveBonus = 10
	},
	function create()
	{
		this.aura_abstract_effect.create();
		this.m.ID = "effects.rf_legatus_command";
		this.m.Name = "Legatus Command";
		this.m.Description = "This character is in the presence of a Legatus.";
		this.m.Icon = "skills/rf_legatus_command_effect.png";
		this.m.IconMini = "rf_legatus_command_effect_mini";
		this.m.Overlay = "rf_legatus_command_effect";
		this.m.AuraScript = "scripts/skills/perks/perk_rf_legatus";
		this.m.AuraID = "perk.rf_legatus";
		this.m.AuraRange = 8;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizePercentage(this.m.DamageMult * 100 - 100) + " increased [Damage|Concept.Hitpoints] dealt")
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizePercentage(100 - this.m.DamageMult * 100) + " reduced [Damage|Concept.Hitpoints] received")
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.ResolveBonus) + " [Resolve|Concept.Resolve]")
			}
		]);

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (this.getAuraProvider() != null)
		{
			_properties.DamageTotalMult *= this.m.DamageMult;
			_properties.DamageReceivedTotalMult *= this.m.DamageReceivedMult;
			_properties.Bravery += this.m.ResolveBonus;
		}
	}
});
