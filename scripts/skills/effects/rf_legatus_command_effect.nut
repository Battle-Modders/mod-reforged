this.rf_legatus_command_effect <- ::inherit("scripts/skills/skill", {
	m = {
		DamageMult = 1.1,
		DamageReceivedMult = 0.9,
		ResolveBonus = 30
	},
	function create()
	{
		this.m.ID = "effects.rf_legatus_command";
		this.m.Name = "Legatus Command";
		this.m.Description = "This character is in the presence of a Legatus.";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Icon = "skills/rf_legatus_command_effect.png";
		this.m.IconMini = "rf_legatus_command_effect_mini";
		this.m.IsSerialized = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizePercentage(this.m.DamageMult * 100 - 100, {AddSign = false}) + " increased [Damage|Concept.Hitpoints] dealt")
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizePercentage(100 - this.m.DamageMult * 100, {AddSign = false}) + " reduced [Damage|Concept.Hitpoints] received")
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.ResolveBonus) + " [Resolve|Concept.Resolve]")
			}
		]);

		return tooltip;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = true;

		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return;

		local myTile = actor.getTile();
		foreach (ally in ::Tactical.Entities.getAlliedActors(actor.getFaction(), myTile, 8))
		{
			if (ally.getSkills().hasSkill("perk.rf_legatus"))
			{
				this.m.IsHidden = false;
				_properties.DamageTotalMult *= this.m.DamageMult;
				_properties.DamageReceivedTotalMult *= this.m.DamageReceivedMult;
				_properties.Bravery += this.m.ResolveBonus;
				break;
			}
		}
	}
});
